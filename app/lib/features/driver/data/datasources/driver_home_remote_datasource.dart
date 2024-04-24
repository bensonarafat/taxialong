import 'dart:convert';

import 'package:taxialong/core/constants/constants.dart';
import 'package:taxialong/core/error/execptions.dart';
import 'package:taxialong/core/services/secure_storage.dart';
import 'package:taxialong/features/driver/data/models/driver_location_model.dart';
import 'package:taxialong/features/driver/data/models/driver_model.dart';
import 'package:taxialong/features/driver/data/models/go_online_model.dart';
import 'package:taxialong/features/driver/data/models/trip_model.dart';
import 'package:taxialong/features/driver/domain/usecases/update_driver_location_usecase.dart';

abstract class DriverHomeRemoteDataSource {
  Future<GoOnlineModel> goOnline();
  Future<DriverModel> getDriverData();
  Future<DriverLocationModel> updateDriverLocation(LocationParams params);
  Future<List<TripModel>> getRecents();
  Future<List<TripModel>> getRequests();
}

class DriverHomeRemoteDataSourceImpl implements DriverHomeRemoteDataSource {
  final SecureStorage secureStorage;
  final dynamic client;

  DriverHomeRemoteDataSourceImpl({
    required this.secureStorage,
    required this.client,
  });

  @override
  Future<GoOnlineModel> goOnline() async {
    final token = await secureStorage.getToken();

    if (token == null) throw ServerException();
    var headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };
    var url = Uri.parse("${endpoint}driver/go-online");
    var response = await client.get(
      url,
      headers: headers,
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return GoOnlineModel.fromJson(data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<DriverModel> getDriverData() async {
    final token = await secureStorage.getToken();

    if (token == null) throw ServerException();
    var headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };
    var url = Uri.parse("${endpoint}driver");
    var response = await client.get(
      url,
      headers: headers,
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return DriverModel.fromJson(data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<DriverLocationModel> updateDriverLocation(
      LocationParams params) async {
    final token = await secureStorage.getToken();

    if (token == null) throw ServerException();
    var headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };
    var url = Uri.parse("${endpoint}driver/update-position");
    var response = await client.post(url, headers: headers, body: {
      "latitude": params.latitude,
      "longitude": params.longitude,
    });
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      return DriverLocationModel.fromJson(data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TripModel>> getRecents() async {
    final token = await secureStorage.getToken();
    if (token == null) throw ServerException();
    var headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };
    var url = Uri.parse("${endpoint}trips/recent");
    var response = await client.get(
      url,
      headers: headers,
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<dynamic> jsonresponse = data['data'];
      List<TripModel> list =
          jsonresponse.map((item) => TripModel.fromJson(item)).toList();
      return list;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TripModel>> getRequests() async {
    final token = await secureStorage.getToken();
    if (token == null) throw ServerException();
    var headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };
    var url = Uri.parse("${endpoint}trips/requests");
    var response = await client.get(
      url,
      headers: headers,
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      List<dynamic> jsonresponse = data['data'];

      List<TripModel> list =
          jsonresponse.map((item) => TripModel.fromJson(item)).toList();
      return list;
    } else {
      throw ServerException();
    }
  }
}

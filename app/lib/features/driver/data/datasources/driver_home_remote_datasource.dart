import 'dart:convert';

import 'package:taxialong/core/constants/constants.dart';
import 'package:taxialong/core/error/execptions.dart';
import 'package:taxialong/core/services/secure_storage.dart';
import 'package:taxialong/features/driver/data/models/driver_model.dart';
import 'package:taxialong/features/driver/data/models/go_online_model.dart';

abstract class DriverHomeRemoteDataSource {
  Future<GoOnlineModel> goOnline();
  Future<DriverModel> getDriverData();
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
}

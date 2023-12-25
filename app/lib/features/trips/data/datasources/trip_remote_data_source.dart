import 'dart:convert';

import 'package:taxialong/core/constants/constants.dart';
import 'package:taxialong/core/error/execptions.dart';
import 'package:taxialong/core/services/secure_storage.dart';
import 'package:taxialong/features/trips/data/models/trip_model.dart';

abstract class TripRemoteDataSource {
  Future<TripModel> getTrip();
}

class TripRemoteDataSourceImpl implements TripRemoteDataSource {
  final SecureStorage secureStorage;
  final dynamic client;

  TripRemoteDataSourceImpl({required this.secureStorage, required this.client});

  @override
  Future<TripModel> getTrip() async {
    final token = await secureStorage.getToken();

    if (token == null) throw ServerException();
    var headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };
    var url = Uri.parse("${endpoint}trips/requests");
    var response = await client.get(url, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      return TripModel.fromJson(data);
    } else {
      throw ServerException();
    }
  }
}

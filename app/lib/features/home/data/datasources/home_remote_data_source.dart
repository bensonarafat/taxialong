import 'dart:convert';

import 'package:taxialong/core/constants/constants.dart';
import 'package:taxialong/core/error/execptions.dart';
import 'package:taxialong/core/services/secure_storage.dart';
import 'package:taxialong/features/home/data/models/axis_model.dart';

abstract class HomeRemoteDataSource {
  Future<AxisModel> getAxis({required params});
}

class HomeRemoteDataSourceImp implements HomeRemoteDataSource {
  final dynamic client;
  final SecureStorage secureStorage;

  HomeRemoteDataSourceImp({required this.client, required this.secureStorage});

  @override
  Future<AxisModel> getAxis({required params}) async {
    final token = await secureStorage.getToken();
    if (token == null) throw ServerException();
    var headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };
    var url = Uri.parse("${endpoint}terminal/axis");
    var response = await client.post(
      url,
      body: {
        "latitude": params.latitude,
        "longitude": params.longitude,
      },
      headers: headers,
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return AxisModel.fromJson(data);
    } else {
      throw ServerException();
    }
  }
}

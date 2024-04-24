import 'dart:convert';

import 'package:taxialong/core/constants/constants.dart';
import 'package:taxialong/core/error/execptions.dart';
import 'package:taxialong/core/services/secure_storage.dart';
import 'package:taxialong/features/home/data/models/axis_model.dart';
import 'package:taxialong/features/home/domain/usecases/get_axis.dart';

abstract class HomeRemoteDataSource {
  Future<List<AxisModel>> getAxis({required PositionParams params});
}

class HomeRemoteDataSourceImp implements HomeRemoteDataSource {
  final dynamic client;
  final SecureStorage secureStorage;

  HomeRemoteDataSourceImp({required this.client, required this.secureStorage});

  @override
  Future<List<AxisModel>> getAxis({required PositionParams params}) async {
    final token = await secureStorage.getToken();
    if (token == null) throw ServerException();
    var headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };
    var url = Uri.parse("${endpoint}terminal/axis");
    // ignore: prefer_typing_uninitialized_variables
    late final response;
    if (params.latitude == null || params.longitude == null) {
      response = await client.post(
        url,
        headers: headers,
      );
    } else {
      response = await client.post(
        url,
        body: {
          "latitude": params.latitude,
          "longitude": params.longitude,
        },
        headers: headers,
      );
    }

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<dynamic> jsonresponse = data['data'];
      List<AxisModel> list =
          jsonresponse.map((item) => AxisModel.fromJson(item)).toList();
      return list;
    } else {
      throw ServerException();
    }
  }
}

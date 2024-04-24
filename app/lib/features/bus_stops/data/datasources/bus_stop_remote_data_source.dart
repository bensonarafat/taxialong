import 'dart:convert';

import 'package:taxialong/core/constants/constants.dart';
import 'package:taxialong/core/error/execptions.dart';
import 'package:taxialong/core/services/secure_storage.dart';
import 'package:taxialong/features/bus_stops/data/models/axis_model.dart';
import 'package:taxialong/features/bus_stops/domain/usecases/get_bus_stop_usecase.dart';

abstract class BusStopRemoteDataSource {
  Future<List<AxisModel>> fetchBusStop(AxisParams params);
}

class BusStopRemoteDataSourceImpl implements BusStopRemoteDataSource {
  final dynamic client;
  final SecureStorage secureStorage;

  BusStopRemoteDataSourceImpl(
      {required this.client, required this.secureStorage});

  @override
  Future<List<AxisModel>> fetchBusStop(AxisParams params) async {
    final token = await secureStorage.getToken();
    if (token == null) throw ServerException();
    var headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };
    var url = Uri.parse("${endpoint}terminal/bus-stops");
    var response = await client.post(
      url,
      headers: headers,
      body: {
        'pointb': params.pointa,
        'pointa': params.pointb,
      },
    );
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

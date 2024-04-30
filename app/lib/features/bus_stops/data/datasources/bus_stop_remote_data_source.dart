import 'package:dio/dio.dart';
import 'package:taxialong/core/constants/constants.dart';
import 'package:taxialong/core/error/execptions.dart';
import 'package:taxialong/core/services/secure_storage.dart';
import 'package:taxialong/features/bus_stops/data/models/axis_model.dart';
import 'package:taxialong/features/bus_stops/domain/usecases/get_bus_stop_usecase.dart';

abstract class BusStopRemoteDataSource {
  Future<List<AxisModel>> fetchBusStop(AxisParams params);
}

class BusStopRemoteDataSourceImpl implements BusStopRemoteDataSource {
  final Dio dio;
  final SecureStorage secureStorage;

  BusStopRemoteDataSourceImpl(
      {required this.dio, required this.secureStorage}) {
    dio.options.headers["Accept"] = "application/json";
  }

  @override
  Future<List<AxisModel>> fetchBusStop(AxisParams params) async {
    final token = await secureStorage.getToken();
    if (token == null) throw ServerException();
    dio.options.headers["Authorization"] = 'Bearer $token';
    var url = "${endpoint}terminal/bus-stops";
    var response = await dio.post(
      url,
      data: {
        'pointb': params.pointa,
        'pointa': params.pointb,
      },
    );
    if (response.statusCode == 200) {
      var data = response.data;
      List<dynamic> jsonresponse = data['data'];
      List<AxisModel> list =
          jsonresponse.map((item) => AxisModel.fromJson(item)).toList();
      return list;
    } else {
      throw ServerException();
    }
  }
}

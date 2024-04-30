import 'package:dio/dio.dart';
import 'package:taxialong/core/constants/constants.dart';
import 'package:taxialong/core/error/execptions.dart';
import 'package:taxialong/core/services/secure_storage.dart';
import 'package:taxialong/features/home/data/models/axis_model.dart';
import 'package:taxialong/features/home/domain/usecases/get_axis.dart';

abstract class HomeRemoteDataSource {
  Future<List<AxisModel>> getAxis({required PositionParams params});
}

class HomeRemoteDataSourceImp implements HomeRemoteDataSource {
  final Dio dio;
  final SecureStorage secureStorage;

  HomeRemoteDataSourceImp({required this.dio, required this.secureStorage}) {
    dio.options.headers["Accept"] = "application/json";
  }

  @override
  Future<List<AxisModel>> getAxis({required PositionParams params}) async {
    final token = await secureStorage.getToken();
    if (token == null) throw ServerException();
    dio.options.headers["Authorization"] = 'Bearer $token';
    var url = "${endpoint}terminal/axis";
    // ignore: prefer_typing_uninitialized_variables
    late var response;

    if (params.latitude == null || params.longitude == null) {
      response = await dio.post(
        url,
      );
    } else {
      response = await dio.post(
        url,
        data: {
          "latitude": params.latitude,
          "longitude": params.longitude,
        },
      );
    }

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

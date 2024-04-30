import 'package:dio/dio.dart';
import 'package:taxialong/core/constants/constants.dart';
import 'package:taxialong/core/error/execptions.dart';
import 'package:taxialong/core/services/secure_storage.dart';
import 'package:taxialong/features/vehicle/data/models/create_car_model.dart';
import 'package:taxialong/features/vehicle/domain/usecases/create_car_usecase.dart';

abstract class CarRemoteDataSource {
  Future<CreateCarModel> createCar(CarParams params);
}

class CarRemoteDataSourceImpl implements CarRemoteDataSource {
  final SecureStorage secureStorage;
  final Dio dio;

  CarRemoteDataSourceImpl({required this.secureStorage, required this.dio}) {
    dio.options.headers["Accept"] = "application/json";
  }

  @override
  Future<CreateCarModel> createCar(CarParams params) async {
    final token = await secureStorage.getToken();

    if (token == null) throw ServerException();
    dio.options.headers["Authorization"] = 'Bearer $token';
    var url = "${endpoint}car/create-car";
    var response = await dio.post(url, data: {
      "model": params.model,
      "color": params.color,
      "seats": params.seats,
      "plateNumber": params.plateNumber,
    });
    if (response.statusCode == 200) {
      var data = response.data;

      return CreateCarModel.fromJson(data);
    } else {
      throw ServerException();
    }
  }
}

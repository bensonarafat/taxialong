import 'package:dio/dio.dart';
import 'package:taxialong/core/constants/constants.dart';
import 'package:taxialong/core/error/execptions.dart';
import 'package:taxialong/core/services/secure_storage.dart';
import 'package:taxialong/features/vehicle/data/models/car_model.dart';
import 'package:taxialong/features/vehicle/data/models/cars_model.dart';
import 'package:taxialong/features/vehicle/data/models/create_car_model.dart';
import 'package:taxialong/features/vehicle/domain/usecases/create_car_usecase.dart';
import 'package:taxialong/features/vehicle/domain/usecases/delete_car_usecase.dart';
import 'package:taxialong/features/vehicle/domain/usecases/edit_car_usecase.dart';

abstract class CarRemoteDataSource {
  Future<CreateCarModel> createCar(CarParams params);
  Future<CarsModel> fetchVehicles();
  Future<CreateCarModel> updateDefault(CarParam params);
  Future<CreateCarModel> deleteCar(CarParam params);
  Future<CarModel> fetchCar(CarParam params);
  Future<CreateCarModel> updateCar(EditCarParams params);
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
    var url = "${endpoint}car/create";
    var response = await dio.post(url, data: {
      "model": params.model,
      "color": params.color,
      "seatId": params.seatId,
      "plateNumber": params.plateNumber,
      "classes": params.classes,
    });

    if (response.statusCode == 200) {
      var data = response.data;
      return CreateCarModel.fromJson(data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<CarsModel> fetchVehicles() async {
    final token = await secureStorage.getToken();
    if (token == null) throw ServerException();
    dio.options.headers["Authorization"] = 'Bearer $token';
    var url = "${endpoint}car/cars";
    var response = await dio.get(url);

    if (response.statusCode == 200) {
      var data = response.data;
      return CarsModel.fromJson(data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<CreateCarModel> updateDefault(CarParam params) async {
    final token = await secureStorage.getToken();

    if (token == null) throw ServerException();
    dio.options.headers["Authorization"] = 'Bearer $token';
    var url = "${endpoint}car/set-default/${params.id}";
    var response = await dio.get(url);

    if (response.statusCode == 200) {
      var data = response.data;
      return CreateCarModel.fromJson(data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<CreateCarModel> deleteCar(CarParam params) async {
    final token = await secureStorage.getToken();
    if (token == null) throw ServerException();
    dio.options.headers["Authorization"] = 'Bearer $token';
    var url = "${endpoint}car/delete/${params.id}";
    var response = await dio.delete(url);

    if (response.statusCode == 200) {
      var data = response.data;
      return CreateCarModel.fromJson(data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<CarModel> fetchCar(CarParam params) async {
    final token = await secureStorage.getToken();

    if (token == null) throw ServerException();
    dio.options.headers["Authorization"] = 'Bearer $token';
    var url = "${endpoint}car/get/${params.id}";
    var response = await dio.get(url);

    if (response.statusCode == 200) {
      var data = response.data;
      return CarModel.fromJson(data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<CreateCarModel> updateCar(EditCarParams params) async {
    final token = await secureStorage.getToken();

    if (token == null) throw ServerException();
    dio.options.headers["Authorization"] = 'Bearer $token';
    var url = "${endpoint}car/update/${params.id}";
    var response = await dio.put(url, data: {
      "model": params.model,
      "color": params.color,
      "seatId": params.seatId,
      "plateNumber": params.plateNumber,
      "classes": params.classes,
    });

    if (response.statusCode == 200) {
      var data = response.data;
      return CreateCarModel.fromJson(data);
    } else {
      throw ServerException();
    }
  }
}

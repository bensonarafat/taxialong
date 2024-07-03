import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:taxialong/core/constants/constants.dart';
import 'package:taxialong/core/error/execptions.dart';
import 'package:taxialong/core/services/secure_storage.dart';
import 'package:taxialong/features/rides/data/models/confirm_ride_model.dart';
import 'package:taxialong/features/rides/data/models/rides_model.dart';
import 'package:taxialong/features/rides/domain/usecases/confirm_ride_usecase.dart';
import 'package:taxialong/features/rides/domain/usecases/get_rides_usecase.dart';

abstract class RideRemoteDataSource {
  Future<List<RidesModel>> getAvaiableRides(RideParams params);
  Future<ConfirmRideModel> confirmRide(ConfirmRideParams params);
}

class RideRemoteDataSourceImpl implements RideRemoteDataSource {
  final SecureStorage secureStorage;
  final Dio dio;

  RideRemoteDataSourceImpl({
    required this.secureStorage,
    required this.dio,
  }) {
    dio.options.headers["Accept"] = "application/json";
  }
  @override
  Future<List<RidesModel>> getAvaiableRides(RideParams params) async {
    final token = await secureStorage.getToken();
    if (token == null) throw ServerException();
    dio.options.headers["Authorization"] = 'Bearer $token';
    var url = "${endpoint}trips/available-rides";

    Map<String, dynamic> data = {
      "pointAlatitude": params.latitude,
      "pointAlongitude": params.longitude,
      "pointb": params.pointb,
    };

    if (params.rideClass != null) {
      data['rider_class'] = jsonEncode(params.rideClass);
    }
    final response = await dio.post(
      url,
      data: data,
    );

    if (response.statusCode == 200) {
      var data = response.data;

      List<dynamic> jsonresponse = data['data'];
      List<RidesModel> list =
          jsonresponse.map((item) => RidesModel.fromJson(item)).toList();
      return list;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ConfirmRideModel> confirmRide(ConfirmRideParams params) async {
    final token = await secureStorage.getToken();

    if (token == null) throw ServerException();
    dio.options.headers["Authorization"] = 'Bearer $token';
    var url = "${endpoint}trips/confirm-ride";

    var response = await dio.post(url, data: {
      "seats": jsonEncode(params.seats),
      "payment_method": params.paymentMethod.toLowerCase(),
      "driver_id": params.driverId,
      "pointa": params.pointa,
      "pointb": params.pointb,
      "ride_class": jsonEncode(params.rideClass),
      "car_id": params.carId,
    });

    if (response.statusCode == 200) {
      var data = response.data;

      return ConfirmRideModel.fromJson(data);
    } else {
      throw ServerException();
    }
  }
}

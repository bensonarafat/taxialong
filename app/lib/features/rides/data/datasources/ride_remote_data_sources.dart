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
    if (params.seat != null) {
      data['seat'] = params.seat;
    }
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
      "amount": params.amount,
      "payment_method": params.paymentMethod.toLowerCase(),
      "driver_id": params.driverId,
      "seats": jsonEncode(params.seats),
      "pointa": params.pointa,
      "pointb": params.pointb,
      "trip_class": params.tripClass,
    });
    if (response.statusCode == 200) {
      var data = response.data;

      return ConfirmRideModel.fromJson(data);
    } else {
      throw ServerException();
    }
  }
}

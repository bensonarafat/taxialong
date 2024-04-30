import 'package:dio/dio.dart';
import 'package:taxialong/core/constants/constants.dart';
import 'package:taxialong/core/error/execptions.dart';
import 'package:taxialong/core/services/secure_storage.dart';
import 'package:taxialong/features/trips/data/models/cancel_model.dart';
import 'package:taxialong/features/trips/data/models/trip_model.dart';
import 'package:taxialong/features/trips/data/models/update_trip_model.dart';

abstract class TripRemoteDataSource {
  Future<TripModel> getTrip();
  Future<CancelModel> cancelTrip(params);
  Future<UpdateTripModel> updateComplete();
  Future<UpdateTripModel> updatePickUp();
}

class TripRemoteDataSourceImpl implements TripRemoteDataSource {
  final SecureStorage secureStorage;
  final Dio dio;

  TripRemoteDataSourceImpl({required this.secureStorage, required this.dio}) {
    dio.options.headers["Accept"] = "application/json";
  }

  @override
  Future<TripModel> getTrip() async {
    final token = await secureStorage.getToken();

    if (token == null) throw ServerException();
    dio.options.headers["Authorization"] = 'Bearer $token';
    var url = "${endpoint}trips/requests";
    var response = await dio.get(url);
    if (response.statusCode == 200) {
      var data = response.data;

      return TripModel.fromJson(data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<CancelModel> cancelTrip(params) async {
    final token = await secureStorage.getToken();

    if (token == null) throw ServerException();
    dio.options.headers["Authorization"] = 'Bearer $token';
    var url = "${endpoint}trips/cancel";
    var response = await dio.post(
      url,
      data: {
        "tripId": params.tripId,
        "reason": params.reason,
      },
    );
    if (response.statusCode == 200) {
      var data = response.data;

      return CancelModel.fromJson(data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UpdateTripModel> updateComplete() async {
    final token = await secureStorage.getToken();

    if (token == null) throw ServerException();
    dio.options.headers["Authorization"] = 'Bearer $token';
    var url = "${endpoint}trips/update-completed";
    var response = await dio.get(url);
    if (response.statusCode == 200) {
      var data = response.data;

      return UpdateTripModel.fromJson(data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UpdateTripModel> updatePickUp() async {
    final token = await secureStorage.getToken();

    if (token == null) throw ServerException();
    dio.options.headers["Authorization"] = 'Bearer $token';
    var url = "${endpoint}trips/update-pickup";
    var response = await dio.get(url);
    if (response.statusCode == 200) {
      var data = response.data;

      return UpdateTripModel.fromJson(data);
    } else {
      throw ServerException();
    }
  }
}

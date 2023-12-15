import 'dart:convert';

import 'package:taxialong/core/constants/constants.dart';
import 'package:taxialong/core/error/execptions.dart';
import 'package:taxialong/core/services/secure_storage.dart';
import 'package:taxialong/features/rides/data/models/rides_model.dart';
import 'package:taxialong/features/rides/domain/usecases/get_rides_usecase.dart';

abstract class RideRemoteDataSource {
  Future<List<RidesModel>> getAvaiableRides(RideParams params);
}

class RideRemoteDataSourceImpl implements RideRemoteDataSource {
  final SecureStorage secureStorage;
  final dynamic client;

  RideRemoteDataSourceImpl({
    required this.secureStorage,
    required this.client,
  });
  @override
  Future<List<RidesModel>> getAvaiableRides(RideParams params) async {
    final token = await secureStorage.getToken();
    if (token == null) throw ServerException();
    var headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };
    var url = Uri.parse("${endpoint}trips/available-rides");

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
    final response = await client.post(
      url,
      body: data,
      headers: headers,
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<dynamic> jsonresponse = data['data'];
      List<RidesModel> list =
          jsonresponse.map((item) => RidesModel.fromJson(item)).toList();
      return list;
    } else {
      throw ServerException();
    }
  }
}

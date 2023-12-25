import 'package:taxialong/features/rides/data/models/trip_model.dart';
import 'package:taxialong/features/rides/domain/entities/confirm_ride_entity.dart';

class ConfirmRideModel extends ConfirmRideEntity {
  ConfirmRideModel({
    required super.status,
    required super.message,
    required super.trip,
  });

  factory ConfirmRideModel.fromJson(Map<String, dynamic> json) {
    TripModel? trip;
    if (json['data'] != null) {
      trip = TripModel.fromJson(json['data']);
    }

    return ConfirmRideModel(
      status: json['status'],
      message: json['message'],
      trip: trip,
    );
  }
}

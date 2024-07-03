import 'package:taxialong/features/trips/data/models/trip_model.dart';
import 'package:taxialong/features/trips/domain/entities/update_trip_entity.dart';

class UpdateTripModel extends UpdateTripEntity {
  UpdateTripModel({
    required super.status,
    required super.message,
    required super.trip,
  });

  factory UpdateTripModel.fromJson(Map<String, dynamic> json) {
    TripModel? trip;
    if (json['data'] != null) {
      trip = TripModel.fromJson(json['data']);
    }
    return UpdateTripModel(
      status: json['status'],
      message: json['message'],
      trip: trip,
    );
  }
}

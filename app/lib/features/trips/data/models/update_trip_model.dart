import 'package:taxialong/features/trips/domain/entities/update_trip_entity.dart';

class UpdateTripModel extends UpdateTripEntity {
  UpdateTripModel({required super.status, required super.message});

  factory UpdateTripModel.fromJson(Map<String, dynamic> json) {
    return UpdateTripModel(status: json['status'], message: json['message']);
  }
}

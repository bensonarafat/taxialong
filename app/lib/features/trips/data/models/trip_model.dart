import 'package:taxialong/features/trips/domain/entities/trip_entity.dart';

class TripModel extends TripEntity {
  TripModel(
      {required super.id, required super.riderId, required super.driverId});

  factory TripModel.fromJson(Map<String, dynamic> json) {
    return TripModel(
      id: json['id'],
      riderId: json['rider_id'],
      driverId: json['driver_id'],
    );
  }
}

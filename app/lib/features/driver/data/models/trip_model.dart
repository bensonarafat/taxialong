import 'dart:convert';

import 'package:taxialong/features/driver/data/models/location_model.dart';
import 'package:taxialong/features/driver/data/models/point_model.dart';
import 'package:taxialong/features/driver/data/models/rider_model.dart';
import 'package:taxialong/features/driver/domain/entities/trip_entity.dart';

class TripModel extends TripEntity {
  TripModel({
    required super.id,
    required super.riderId,
    required super.driverId,
    required super.pointa,
    required super.pointb,
    required super.paymentMethod,
    required super.amount,
    required super.tripClass,
    required super.seats,
    required super.status,
    required super.rider,
    required super.location,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) {
    PointModel pointa = PointModel.fromJson(json['pointa']);
    PointModel pointb = PointModel.fromJson(json['pointb']);
    LocationModel location = LocationModel.fromJson(json['location']);
    RiderModel rider = RiderModel.fromJson(json['rider']);

    return TripModel(
      id: json['id'],
      riderId: json['rider_id'],
      driverId: json['driver_id'],
      pointa: pointa,
      pointb: pointb,
      paymentMethod: json['payment_method'],
      amount: json['amount'],
      tripClass: json['trip_class'],
      seats: jsonDecode(json['seats']),
      status: json['status'],
      rider: rider,
      location: location,
    );
  }
}

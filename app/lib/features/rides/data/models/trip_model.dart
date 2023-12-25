import 'dart:convert';

import 'package:taxialong/features/rides/data/models/driver_model.dart';
import 'package:taxialong/features/rides/data/models/location_model.dart';
import 'package:taxialong/features/rides/data/models/point_model.dart';
import 'package:taxialong/features/rides/data/models/review_model.dart';
import 'package:taxialong/features/rides/domain/entities/trip_entity.dart';

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
    required super.reviewsAvg,
    required super.driver,
    required super.location,
    required super.reviews,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) {
    PointModel pointa = PointModel.fromJson(json['pointa']);
    PointModel pointb = PointModel.fromJson(json['pointb']);
    LocationModel location = LocationModel.fromJson(json['location']);
    DriverModel driver = DriverModel.fromJson(json['driver']);

    List<dynamic> jsonresponse = json['reviews'];
    List<ReviewModel> reviews =
        jsonresponse.map((item) => ReviewModel.fromJson(item)).toList();
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
      reviewsAvg: json['reviews_avg_rating'],
      driver: driver,
      location: location,
      reviews: reviews,
    );
  }
}

import 'dart:convert';

import 'package:taxialong/features/bus_stops/data/models/bus_stop_model.dart';
import 'package:taxialong/features/rides/data/models/driver_model.dart';
import 'package:taxialong/features/rides/data/models/location_model.dart';
import 'package:taxialong/features/rides/data/models/point_model.dart';
import 'package:taxialong/features/rides/data/models/review_model.dart';
import 'package:taxialong/features/trips/domain/entities/trip_entity.dart';
import 'package:taxialong/features/vehicle/data/models/car_model.dart';

class TripModel extends TripEntity {
  TripModel({
    required super.id,
    required super.riderId,
    required super.driverId,
    required super.pointa,
    required super.pointb,
    required super.paymentMethod,
    required super.amount,
    required super.rideClass,
    required super.seats,
    required super.status,
    required super.driver,
    required super.location,
    required super.reviews,
    required super.busStops,
    required super.car,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) {
    PointModel pointa = PointModel.fromJson(json['pointa']);
    PointModel pointb = PointModel.fromJson(json['pointb']);
    LocationModel location = LocationModel.fromJson(json['location']);
    CarModel car = CarModel.fromJson(json['car']);
    DriverModel? driver;

    if (json['driver'] != null) {
      driver = DriverModel.fromJson(json['driver']);
    }
    List<ReviewModel>? reviews;
    if (json['reviews'] != null) {
      List<dynamic> jsonresponse = json['reviews'];
      reviews = jsonresponse.map((item) => ReviewModel.fromJson(item)).toList();
    }
    List<BusStopModel>? busStops;
    if (json['bus_stops'] != null) {
      List<dynamic> jsonresponsebusStops = json['bus_stops'];
      busStops = jsonresponsebusStops
          .map((item) => BusStopModel.fromJson(item))
          .toList();
    }

    return TripModel(
      id: json['id'],
      riderId: json['rider_id'],
      driverId: json['driver_id'],
      pointa: pointa,
      pointb: pointb,
      paymentMethod: json['payment_method'],
      amount: json['amount'],
      rideClass: json['ride_class'],
      seats: jsonDecode(json['seats']),
      status: json['status'],
      driver: driver,
      location: location,
      reviews: reviews,
      busStops: busStops,
      car: car,
    );
  }
}

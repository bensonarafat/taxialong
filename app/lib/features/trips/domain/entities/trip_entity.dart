import 'package:taxialong/features/bus_stops/domain/entities/bus_stop_entity.dart';
import 'package:taxialong/features/rides/domain/entities/driver_entity.dart';
import 'package:taxialong/features/rides/domain/entities/location_entity.dart';
import 'package:taxialong/features/rides/domain/entities/point_entity.dart';
import 'package:taxialong/features/rides/domain/entities/review_entity.dart';
import 'package:taxialong/features/vehicle/domain/entities/car_entity.dart';

class TripEntity {
  final int id;
  final int riderId;
  final int driverId;
  final PointEntity pointa;
  final PointEntity pointb;
  final String paymentMethod;
  final String amount;
  final String rideClass;
  final List<dynamic> seats;
  final String status;
  final DriverEntity? driver;
  final LocationEntity location;
  final List<ReviewEntity>? reviews;
  final List<BusStopEntity>? busStops;
  final CarEntity car;

  TripEntity({
    required this.id,
    required this.riderId,
    required this.driverId,
    required this.pointa,
    required this.pointb,
    required this.paymentMethod,
    required this.amount,
    required this.rideClass,
    required this.seats,
    required this.status,
    required this.driver,
    required this.location,
    required this.reviews,
    required this.busStops,
    required this.car,
  });
}

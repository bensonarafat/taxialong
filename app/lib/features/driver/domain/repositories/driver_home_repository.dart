import 'package:dartz/dartz.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/features/driver/domain/entities/driver_entity.dart';
import 'package:taxialong/features/driver/domain/entities/driver_location_entity.dart';
import 'package:taxialong/features/driver/domain/entities/go_online_entity.dart';
import 'package:taxialong/features/trips/domain/entities/trip_entity.dart';

abstract class DriverHomeRepository {
  Future<Either<Failure, GoOnlineEntity>> goOnline();
  Future<Either<Failure, DriverEntity>> getDriverData();
  Future<Either<Failure, DriverLocationEntity>> updateDriverLocation(params);
  Future<Either<Failure, List<TripEntity>>> getRequests();
  Future<Either<Failure, List<TripEntity>>> getRecents();
}

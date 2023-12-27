import 'package:dartz/dartz.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/features/trips/domain/entities/cancel_entity.dart';
import 'package:taxialong/features/trips/domain/entities/trip_entity.dart';
import 'package:taxialong/features/trips/domain/entities/update_trip_entity.dart';

abstract class TripRepository {
  Future<Either<Failure, TripEntity>> getTrip();
  Future<Either<Failure, CancelEntity>> cancelTrip(params);
  Future<Either<Failure, UpdateTripEntity>> updatePickUpTrip();
  Future<Either<Failure, UpdateTripEntity>> updateCompleteTrip();
}

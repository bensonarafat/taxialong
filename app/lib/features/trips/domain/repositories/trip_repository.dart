import 'package:dartz/dartz.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/features/trips/domain/entities/trip_entity.dart';

abstract class TripRepository {
  Future<Either<Failure, TripEntity>> getTrip();
}

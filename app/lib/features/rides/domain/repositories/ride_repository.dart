import 'package:dartz/dartz.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/features/rides/domain/entities/rides_entity.dart';

abstract class RideRepository {
  Future<Either<Failure, List<RidesEntity>>> getAvailableRides(params);
}

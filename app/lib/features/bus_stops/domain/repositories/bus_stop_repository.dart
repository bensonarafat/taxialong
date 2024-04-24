import 'package:dartz/dartz.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/features/bus_stops/domain/entities/axis_entity.dart';

abstract class BusStopRepository {
  Future<Either<Failure, List<AxisEntity>>> getBusStops(params);
}

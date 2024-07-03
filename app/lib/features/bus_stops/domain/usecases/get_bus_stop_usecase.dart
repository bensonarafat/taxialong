import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/core/usecases/usecase.dart';
import 'package:taxialong/features/bus_stops/domain/entities/axis_entity.dart';
import 'package:taxialong/features/bus_stops/domain/repositories/bus_stop_repository.dart';

class GetBusStopUseCase implements UseCase<List<AxisEntity>, AxisParams> {
  BusStopRepository repository;
  GetBusStopUseCase({required this.repository});
  @override
  Future<Either<Failure, List<AxisEntity>>> call(AxisParams params) async {
    return repository.getBusStops(params);
  }
}

class AxisParams extends Equatable {
  final int pointa;
  final int pointb;

  const AxisParams({required this.pointa, required this.pointb});
  @override
  List<Object?> get props => [pointb, pointa];
}

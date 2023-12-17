import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/core/usecases/usecase.dart';
import 'package:taxialong/features/rides/domain/entities/rides_entity.dart';
import 'package:taxialong/features/rides/domain/repositories/ride_repository.dart';

class GetRidesUseCase implements UseCase<List<RidesEntity>, RideParams> {
  RideRepository repository;
  GetRidesUseCase({required this.repository});
  @override
  Future<Either<Failure, List<RidesEntity>>> call(RideParams params) async {
    return await repository.getAvailableRides(params);
  }
}

class RideParams extends Equatable {
  final String latitude;
  final String longitude;
  final String pointb;
  final List<dynamic>? rideClass;
  final String? seat;

  const RideParams({
    required this.latitude,
    required this.longitude,
    required this.pointb,
    required this.rideClass,
    required this.seat,
  });

  @override
  List<Object?> get props => [
        latitude,
        longitude,
        pointb,
        rideClass,
        seat,
      ];
}
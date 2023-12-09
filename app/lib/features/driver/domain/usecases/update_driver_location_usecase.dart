import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/core/usecases/usecase.dart';
import 'package:taxialong/features/driver/domain/entities/driver_location_entity.dart';
import 'package:taxialong/features/driver/domain/repositories/driver_home_repository.dart';

class UpdateDriverLocationUseCase
    implements UseCase<DriverLocationEntity, LocationParams> {
  DriverHomeRepository repository;

  UpdateDriverLocationUseCase({required this.repository});
  @override
  Future<Either<Failure, DriverLocationEntity>> call(
      LocationParams params) async {
    return await repository.updateDriverLocation(params);
  }
}

class LocationParams extends Equatable {
  final String latitude;
  final String longitude;

  const LocationParams({required this.latitude, required this.longitude});
  @override
  List<Object?> get props => [latitude, longitude];
}

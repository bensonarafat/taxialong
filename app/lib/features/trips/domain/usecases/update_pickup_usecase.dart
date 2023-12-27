import 'package:dartz/dartz.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/core/usecases/usecase.dart';
import 'package:taxialong/features/trips/domain/entities/update_trip_entity.dart';
import 'package:taxialong/features/trips/domain/repositories/trip_repository.dart';

class UpdatePickUpUseCase extends UseCase<UpdateTripEntity, void> {
  TripRepository repository;
  UpdatePickUpUseCase({required this.repository});
  @override
  Future<Either<Failure, UpdateTripEntity>> call(void params) async {
    return await repository.updatePickUpTrip();
  }
}

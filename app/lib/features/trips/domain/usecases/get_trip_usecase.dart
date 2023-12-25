import 'package:dartz/dartz.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/core/usecases/usecase.dart';
import 'package:taxialong/features/trips/domain/entities/trip_entity.dart';
import 'package:taxialong/features/trips/domain/repositories/trip_repository.dart';

class GetTripUseCase extends UseCase<TripEntity, void> {
  TripRepository repository;
  GetTripUseCase({required this.repository});
  @override
  Future<Either<Failure, TripEntity>> call(void params) async {
    return await repository.getTrip();
  }
}

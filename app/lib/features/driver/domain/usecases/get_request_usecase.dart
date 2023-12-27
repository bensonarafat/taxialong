import 'package:dartz/dartz.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/core/usecases/usecase.dart';
import 'package:taxialong/features/driver/domain/entities/trip_entity.dart';
import 'package:taxialong/features/driver/domain/repositories/driver_home_repository.dart';

class GetRequestUseCase implements UseCase<List<TripEntity>, void> {
  DriverHomeRepository repository;
  GetRequestUseCase({required this.repository});
  @override
  Future<Either<Failure, List<TripEntity>>> call(void params) async {
    return await repository.getRequests();
  }
}
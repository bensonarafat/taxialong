import 'package:dartz/dartz.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/core/usecases/usecase.dart';
import 'package:taxialong/features/driver/domain/entities/driver_entity.dart';
import 'package:taxialong/features/driver/domain/repositories/driver_home_repository.dart';

class GetDriverDataUseCase extends UseCase<DriverEntity, void> {
  DriverHomeRepository repository;
  GetDriverDataUseCase({required this.repository});
  @override
  Future<Either<Failure, DriverEntity>> call(void params) async {
    return await repository.getDriverData();
  }
}

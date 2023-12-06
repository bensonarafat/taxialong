import 'package:dartz/dartz.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/core/usecases/usecase.dart';
import 'package:taxialong/features/driver/domain/entities/go_online_entity.dart';
import 'package:taxialong/features/driver/domain/repositories/driver_home_repository.dart';

class GoOnlineUseCase implements UseCase<GoOnlineEntity, void> {
  DriverHomeRepository repository;
  GoOnlineUseCase({required this.repository});
  @override
  Future<Either<Failure, GoOnlineEntity>> call(void params) async {
    return await repository.goOnline();
  }
}

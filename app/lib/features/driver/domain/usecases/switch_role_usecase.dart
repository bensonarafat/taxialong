import 'package:dartz/dartz.dart';
import 'package:taxialong/core/domain/entities/account_switch_entity.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/core/usecases/usecase.dart';
import 'package:taxialong/features/driver/domain/repositories/driver_home_repository.dart';

class SwitchRoleUseCase extends UseCase<AccountSwitchEntity, void> {
  DriverHomeRepository driverHomeRepository;
  SwitchRoleUseCase({required this.driverHomeRepository});
  @override
  Future<Either<Failure, AccountSwitchEntity>> call(params) async {
    return await driverHomeRepository.switchAccount();
  }
}

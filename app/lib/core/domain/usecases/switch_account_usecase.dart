import 'package:dartz/dartz.dart';
import 'package:taxialong/core/domain/entities/account_switch_entity.dart';
import 'package:taxialong/core/domain/repositories/settings_repository.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/core/usecases/usecase.dart';

class SwitchAccountUseCase implements UseCase<AccountSwitchEntity, void> {
  SettingsRepository repository;

  SwitchAccountUseCase({required this.repository});
  @override
  Future<Either<Failure, AccountSwitchEntity>> call(void params) async {
    return repository.switchAccount();
  }
}

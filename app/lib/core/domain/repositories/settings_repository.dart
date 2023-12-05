import 'package:dartz/dartz.dart';
import 'package:taxialong/core/domain/entities/account_switch_entity.dart';
import 'package:taxialong/core/error/failure.dart';

abstract class SettingsRepository {
  Future<Either<Failure, AccountSwitchEntity>> switchAccount();
}

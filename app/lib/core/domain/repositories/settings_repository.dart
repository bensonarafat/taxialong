import 'package:dartz/dartz.dart';
import 'package:taxialong/core/domain/entities/account_switch_entity.dart';
import 'package:taxialong/core/domain/entities/seats_entity.dart';
import 'package:taxialong/core/domain/entities/settings_update_entity.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/core/domain/entities/terminal_entity.dart';

abstract class SettingsRepository {
  Future<Either<Failure, AccountSwitchEntity>> switchAccount();
  Future<Either<Failure, List<TerminalEntity>>> getTerminals();
  Future<Either<Failure, SettingsUpdateEntity>> updateSettings(params);
  Future<Either<Failure, List<SeatsEntity>>> getSeats();
}

import 'package:dartz/dartz.dart';
import 'package:taxialong/core/domain/repositories/settings_repository.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/core/usecases/usecase.dart';
import 'package:taxialong/core/domain/entities/terminal_entity.dart';

class GetTermainalUseCase implements UseCase<List<TerminalEntity>, void> {
  SettingsRepository repository;
  GetTermainalUseCase({required this.repository});
  @override
  Future<Either<Failure, List<TerminalEntity>>> call(void params) async {
    return await repository.getTerminals();
  }
}

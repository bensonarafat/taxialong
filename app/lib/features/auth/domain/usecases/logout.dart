import 'package:dartz/dartz.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/core/usecases/usecase.dart';
import 'package:taxialong/features/auth/domain/entities/logout_entity.dart';
import 'package:taxialong/features/auth/domain/repositories/auth_repository.dart';

class LogoutUseCase implements UseCase<LogoutEntity, LogoutParams> {
  final AuthRepository repository;

  LogoutUseCase({required this.repository});

  @override
  Future<Either<Failure, LogoutEntity>> call(LogoutParams params) async {
    return await repository.logout();
  }
}

class LogoutParams {}

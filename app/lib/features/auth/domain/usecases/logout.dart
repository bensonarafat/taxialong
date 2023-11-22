import 'package:dartz/dartz.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/features/auth/domain/entities/logout_entity.dart';
import 'package:taxialong/features/auth/domain/repositories/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository repository;

  LogoutUseCase({required this.repository});

  Future<Either<Failure, LogoutEntity>> call() async {
    return await repository.logout();
  }
}

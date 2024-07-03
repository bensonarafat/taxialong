import 'package:dartz/dartz.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/core/usecases/usecase.dart';
import 'package:taxialong/features/auth/domain/entities/verify_auth_entity.dart';
import 'package:taxialong/features/auth/domain/repositories/auth_repository.dart';

class VerifyAuthUseCase implements UseCase<VerifyAuthEntity, void> {
  final AuthRepository repository;
  VerifyAuthUseCase({required this.repository});
  @override
  Future<Either<Failure, VerifyAuthEntity>> call(void params) async {
    return await repository.verifyAuth();
  }
}

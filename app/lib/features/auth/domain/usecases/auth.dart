import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/core/usecases/usecase.dart';
import 'package:taxialong/features/auth/domain/entities/auth_entity.dart';
import 'package:taxialong/features/auth/domain/repositories/auth_repository.dart';

class AuthUseCase implements UseCase<AuthEntity, AuthParams> {
  final AuthRepository repository;

  AuthUseCase({required this.repository});

  @override
  Future<Either<Failure, AuthEntity>> call(AuthParams params) {
    return repository.authUser(params: params);
  }
}

class AuthParams extends Equatable {
  final String telephone;
  final String uuid;
  final String otp;
  final String handler;
  const AuthParams({
    required this.telephone,
    required this.uuid,
    required this.otp,
    required this.handler,
  });
  @override
  List<Object?> get props => [
        telephone,
        uuid,
        otp,
        handler,
      ];
}

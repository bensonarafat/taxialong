import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/core/usecases/usecase.dart';
import 'package:taxialong/features/auth/domain/entities/auth_entity.dart';
import 'package:taxialong/features/auth/domain/repositories/auth_repository.dart';

class CreateAccountUserCase
    implements UseCase<AuthEntity, CreateAccountParams> {
  final AuthRepository repository;

  CreateAccountUserCase({required this.repository});
  @override
  Future<Either<Failure, AuthEntity>> call(CreateAccountParams params) async {
    return await repository.createAccount(params: params);
  }
}

class CreateAccountParams extends Equatable {
  final String firstname;
  final String lastname;
  final String email;
  final String telephone;
  final String uuid;
  const CreateAccountParams({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.telephone,
    required this.uuid,
  });
  @override
  List<Object?> get props => [
        firstname,
        lastname,
        email,
        telephone,
        uuid,
      ];
}

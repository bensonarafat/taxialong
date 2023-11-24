import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/core/usecases/usecase.dart';
import 'package:taxialong/features/auth/domain/entities/telephone_entity.dart';
import 'package:taxialong/features/auth/domain/repositories/auth_repository.dart';

class TelephoneUseCase implements UseCase<TelephoneEntity, TelephoneParams> {
  final AuthRepository repository;

  TelephoneUseCase({required this.repository});

  @override
  Future<Either<Failure, TelephoneEntity>> call(TelephoneParams params) async {
    return await repository.telephone(params: params);
  }
}

class TelephoneParams extends Equatable {
  final String telephone;

  const TelephoneParams({required this.telephone});

  @override
  List<Object?> get props => [telephone];
}

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/core/usecases/usecase.dart';
import 'package:taxialong/features/auth/domain/entities/otp_entity.dart';
import 'package:taxialong/features/auth/domain/repositories/auth_repository.dart';

class VerifyOTPUserCase implements UseCase<OTPEntity, VerifyOTPParams> {
  final AuthRepository repository;

  VerifyOTPUserCase({required this.repository});

  @override
  Future<Either<Failure, OTPEntity>> call(VerifyOTPParams params) async {
    return await repository.verifyOTP(params: params);
  }
}

class VerifyOTPParams extends Equatable {
  final String otp;
  final String telephone;
  final String uuid;
  final String handler;

  const VerifyOTPParams({
    required this.otp,
    required this.telephone,
    required this.uuid,
    required this.handler,
  });

  @override
  List<Object?> get props => [
        otp,
        uuid,
        telephone,
        handler,
      ];
}

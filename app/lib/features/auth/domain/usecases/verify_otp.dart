import 'package:dartz/dartz.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/features/auth/domain/entities/otp_entity.dart';
import 'package:taxialong/features/auth/domain/repositories/auth_repository.dart';

class VerifyOTPUserCase {
  final AuthRepository repository;

  VerifyOTPUserCase({required this.repository});

  Future<Either<Failure, OTPEntity>> call({required params}) async {
    return await repository.verifyOTP(params: params);
  }
}

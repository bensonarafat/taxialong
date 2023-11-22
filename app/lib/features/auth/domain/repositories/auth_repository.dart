import 'package:dartz/dartz.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/features/auth/domain/entities/login_entity.dart';
import 'package:taxialong/features/auth/domain/entities/logout_entity.dart';
import 'package:taxialong/features/auth/domain/entities/otp_entity.dart';
import 'package:taxialong/features/auth/domain/entities/register_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, OTPEntity>> verifyOTP({required params});
  Future<Either<Failure, RegisterEntity>> register({required params});
  Future<Either<Failure, LoginEntity>> createAccount({required params});
  Future<Either<Failure, LogoutEntity>> logout();
}

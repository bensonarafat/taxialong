import 'package:dartz/dartz.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/features/auth/domain/entities/auth_entity.dart';
import 'package:taxialong/features/auth/domain/entities/logout_entity.dart';
import 'package:taxialong/features/auth/domain/entities/otp_entity.dart';
import 'package:taxialong/features/auth/domain/entities/telephone_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, OTPEntity>> verifyOTP({required params});
  Future<Either<Failure, TelephoneEntity>> telephone({required params});
  Future<Either<Failure, AuthEntity>> createAccount({required params});
  Future<Either<Failure, AuthEntity>> authUser({required params});
  Future<Either<Failure, LogoutEntity>> logout();
}

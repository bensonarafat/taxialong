import 'package:dartz/dartz.dart';
import 'package:taxialong/core/connection/network_info.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/core/services/secure_storage.dart';
import 'package:taxialong/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:taxialong/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:taxialong/features/auth/data/models/auth_model.dart';
import 'package:taxialong/features/auth/data/models/logout_model.dart';
import 'package:taxialong/features/auth/data/models/telephone_model.dart';
import 'package:taxialong/features/auth/data/models/verify_otp_model.dart';
import 'package:taxialong/features/auth/domain/entities/auth_entity.dart';
import 'package:taxialong/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final NetworkInfo networkInfo;
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  SecureStorage secureStorage;
  AuthRepositoryImpl({
    required this.networkInfo,
    required this.localDataSource,
    required this.remoteDataSource,
    required this.secureStorage,
  });

  @override
  Future<Either<Failure, AuthModel>> createAccount({required params}) async {
    if (await networkInfo.isConnected) {
      try {
        AuthModel authModel =
            await remoteDataSource.createAccount(params: params);
        // if status true store Bear token
        if (authModel.status) {
          secureStorage.saveToken(authModel.token);
        } else {
          return Left(ServerFailure(message: 'There is a server Error!'));
        }
        return Right(authModel);
      } catch (_) {
        return Left(ServerFailure(message: 'There is a server Error!'));
      }
    } else {
      return Left(
          NetworkFailure(message: 'Please check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, TelephoneModel>> telephone({required params}) async {
    if (await networkInfo.isConnected) {
      try {
        TelephoneModel registerModel =
            await remoteDataSource.telephone(params: params);
        return Right(registerModel);
      } catch (_) {
        return Left(ServerFailure(message: 'There is a server failure!'));
      }
    } else {
      return Left(
          NetworkFailure(message: 'Please check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, VerifyOTPModel>> verifyOTP({required params}) async {
    if (await networkInfo.isConnected) {
      try {
        VerifyOTPModel verifyOTPModel =
            await remoteDataSource.verifyOTP(params: params);
        return Right(verifyOTPModel);
      } catch (_) {
        return Left(ServerFailure(message: "There is a server failure!"));
      }
    } else {
      return Left(
          NetworkFailure(message: "Please check your internet connection"));
    }
  }

  @override
  Future<Either<Failure, LogoutModel>> logout() async {
    if (await networkInfo.isConnected) {
      try {
        LogoutModel logoutModel = await remoteDataSource.logout();
        // remove token
        secureStorage.deleteToken();

        return Right(logoutModel);
      } catch (_) {
        return Left(ServerFailure(message: "There is a server failure"));
      }
    } else {
      return Left(
          NetworkFailure(message: "Please check your internect connection"));
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> authUser({required params}) async {
    if (await networkInfo.isConnected) {
      try {
        AuthModel authModel = await remoteDataSource.authUser(params: params);
        // if status true store Bear token
        if (authModel.status) {
          secureStorage.saveToken(authModel.token);
        } else {
          return Left(ServerFailure(message: 'There is a server Error!'));
        }
        return Right(authModel);
      } catch (_) {
        return Left(ServerFailure(message: 'There is a server Error!'));
      }
    } else {
      return Left(
          NetworkFailure(message: 'Please check your internet connection'));
    }
  }
}

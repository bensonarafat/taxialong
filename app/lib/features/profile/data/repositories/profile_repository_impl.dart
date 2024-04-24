import 'package:dartz/dartz.dart';
import 'package:taxialong/core/connection/network_info.dart';
import 'package:taxialong/core/data/datasources/remote_user_data_source.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/core/services/secure_storage.dart';
import 'package:taxialong/core/data/models/user_model.dart';
import 'package:taxialong/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:taxialong/features/profile/data/models/profile_model.dart';
import 'package:taxialong/features/profile/data/models/profile_photo_model.dart';
import 'package:taxialong/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRemoteDataSource remoteDataSource;
  NetworkInfo networkInfo;
  SecureStorage secureStorage;
  UserDataSource userDataSource;
  ProfileRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
    required this.secureStorage,
    required this.userDataSource,
  });
  @override
  Future<Either<Failure, ProfileModel>> updateProfile(params) async {
    if (await networkInfo.isConnected) {
      try {
        ProfileModel profileModel =
            await remoteDataSource.updateProfile(params);
        // get data and save to device
        UserModel userModel = await userDataSource.getUserData();
        secureStorage.saveUserData(userModel);
        return Right(profileModel);
      } catch (_) {
        return Left(ServerFailure(message: 'There is a server Error!'));
      }
    } else {
      return Left(
          NetworkFailure(message: 'Please check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, ProfilePhotoModel>> updatePhoto(params) async {
    if (await networkInfo.isConnected) {
      try {
        ProfilePhotoModel profileModel =
            await remoteDataSource.updateProfilePhoto(params);
        // get data and save to device
        UserModel userModel = await userDataSource.getUserData();
        secureStorage.saveUserData(userModel);
        return Right(profileModel);
      } catch (_) {
        return Left(ServerFailure(message: 'There is a server Error!'));
      }
    } else {
      return Left(
          NetworkFailure(message: 'Please check your internet connection'));
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:taxialong/core/connection/network_info.dart';
import 'package:taxialong/core/data/datasources/remote_user_data_source.dart';
import 'package:taxialong/core/data/datasources/setting_remote_datasource.dart';
import 'package:taxialong/core/data/models/account_switch_model.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/core/data/models/user_model.dart';
import 'package:taxialong/core/services/secure_storage.dart';
import 'package:taxialong/features/driver/domain/repositories/driver_home_repository.dart';

class DriverHomeRepositoryImpl implements DriverHomeRepository {
  SettingsRemoteDataSource remoteDataSource;
  NetworkInfo networkInfo;
  SecureStorage secureStorage;
  UserDataSource userDataSource;
  DriverHomeRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
    required this.secureStorage,
    required this.userDataSource,
  });
  @override
  Future<Either<Failure, AccountSwitchModel>> switchAccount() async {
    if (await networkInfo.isConnected) {
      try {
        AccountSwitchModel profileModel =
            await remoteDataSource.switchAccount();
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

import 'package:dartz/dartz.dart';
import 'package:taxialong/core/connection/network_info.dart';
import 'package:taxialong/core/data/datasources/remote_user_data_source.dart';
import 'package:taxialong/core/data/datasources/setting_remote_datasource.dart';
import 'package:taxialong/core/data/models/account_switch_model.dart';
import 'package:taxialong/core/data/models/seats_model.dart';
import 'package:taxialong/core/data/models/settings_update_model.dart';
import 'package:taxialong/core/data/models/user_model.dart';
import 'package:taxialong/core/domain/repositories/settings_repository.dart';
import 'package:taxialong/core/error/execptions.dart';
import 'package:taxialong/core/error/failure.dart';

import 'package:taxialong/core/services/secure_storage.dart';
import 'package:taxialong/core/data/models/terminal_model.dart';

class SettingRepositoryImpl implements SettingsRepository {
  SettingsRemoteDataSource remoteDataSource;
  NetworkInfo networkInfo;
  SecureStorage secureStorage;
  UserDataSource userDataSource;
  SettingRepositoryImpl({
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

  @override
  Future<Either<Failure, List<TerminalModel>>> getTerminals() async {
    if (await networkInfo.isConnected) {
      try {
        List<TerminalModel> terminalList =
            await remoteDataSource.getTerminals();

        return Right(terminalList);
      } on ServerException {
        return Left(ServerFailure(message: "There is a server failure"));
      }
    } else {
      return Left(
          NetworkFailure(message: 'Please check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, SettingsUpdateModel>> updateSettings(params) async {
    if (await networkInfo.isConnected) {
      try {
        SettingsUpdateModel settingsUpdateModel =
            await remoteDataSource.updateSettings(params);
        // get data and save to device
        UserModel userModel = await userDataSource.getUserData();
        secureStorage.saveUserData(userModel);
        return Right(settingsUpdateModel);
      } catch (_) {
        return Left(ServerFailure(message: 'There is a server Error!'));
      }
    } else {
      return Left(
          NetworkFailure(message: 'Please check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<SeatsModel>>> getSeats() async {
    if (await networkInfo.isConnected) {
      try {
        List<SeatsModel> model = await remoteDataSource.getSeats();

        return Right(model);
      } catch (_) {
        return Left(
            ServerFailure(message: 'There was an issue! try again later'));
      }
    } else {
      return Left(
          NetworkFailure(message: 'Please check your internet connection'));
    }
  }
}

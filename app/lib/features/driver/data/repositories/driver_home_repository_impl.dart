import 'package:dartz/dartz.dart';
import 'package:taxialong/core/connection/network_info.dart';
import 'package:taxialong/core/data/datasources/remote_user_data_source.dart';
import 'package:taxialong/core/data/models/user_model.dart';
import 'package:taxialong/core/error/execptions.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/core/services/secure_storage.dart';
import 'package:taxialong/features/driver/data/datasources/driver_home_remote_datasource.dart';
import 'package:taxialong/features/driver/data/models/driver_location_model.dart';
import 'package:taxialong/features/driver/data/models/driver_model.dart';
import 'package:taxialong/features/driver/data/models/go_online_model.dart';
import 'package:taxialong/features/driver/domain/repositories/driver_home_repository.dart';
import 'package:taxialong/features/trips/data/models/trip_model.dart';

class DriverHomeRepositoryImpl implements DriverHomeRepository {
  DriverHomeRemoteDataSource remoteDataSource;
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
  Future<Either<Failure, GoOnlineModel>> goOnline() async {
    if (await networkInfo.isConnected) {
      try {
        GoOnlineModel model = await remoteDataSource.goOnline();
        // get user data
        UserModel user = await userDataSource.getUserData();

        secureStorage.saveUserData(user);
        return Right(model);
      } on ServerException {
        return Left(ServerFailure(message: "There is a server failure"));
      }
    } else {
      return Left(
          NetworkFailure(message: 'Please check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, DriverModel>> getDriverData() async {
    if (await networkInfo.isConnected) {
      try {
        DriverModel driverModel = await remoteDataSource.getDriverData();
        return Right(driverModel);
      } on ServerException {
        return Left(ServerFailure(message: "There is a server failure"));
      }
    } else {
      return Left(
          NetworkFailure(message: 'Please check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, DriverLocationModel>> updateDriverLocation(
      params) async {
    if (await networkInfo.isConnected) {
      try {
        DriverLocationModel locationModel =
            await remoteDataSource.updateDriverLocation(params);
        return Right(locationModel);
      } on ServerException {
        return Left(ServerFailure(message: "There is a server failure"));
      }
    } else {
      return Left(
          NetworkFailure(message: 'Please check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<TripModel>>> getRecents() async {
    if (await networkInfo.isConnected) {
      try {
        List<TripModel> tripList = await remoteDataSource.getRecents();
        return Right(tripList);
      } on ServerException {
        return Left(ServerFailure(message: "There is a server failure"));
      }
    } else {
      return Left(
          NetworkFailure(message: 'Please check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<TripModel>>> getRequests() async {
    if (await networkInfo.isConnected) {
      try {
        List<TripModel> tripList = await remoteDataSource.getRequests();
        return Right(tripList);
      } on ServerException {
        return Left(ServerFailure(message: "There is a server failure"));
      }
    } else {
      return Left(
          NetworkFailure(message: 'Please check your internet connection'));
    }
  }
}

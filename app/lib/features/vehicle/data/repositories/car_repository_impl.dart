import 'package:dartz/dartz.dart';
import 'package:taxialong/core/connection/network_info.dart';
import 'package:taxialong/core/error/execptions.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/features/vehicle/data/datasources/car_remote_data_source.dart';
import 'package:taxialong/features/vehicle/data/models/car_model.dart';
import 'package:taxialong/features/vehicle/data/models/cars_model.dart';
import 'package:taxialong/features/vehicle/data/models/create_car_model.dart';
import 'package:taxialong/features/vehicle/domain/entities/create_car_entity.dart';
import 'package:taxialong/features/vehicle/domain/repositories/car_repository.dart';

class CarRepositoryImpl implements CarRepository {
  final NetworkInfo networkInfo;
  final CarRemoteDataSource remoteDataSource;

  CarRepositoryImpl(
      {required this.networkInfo, required this.remoteDataSource});

  @override
  Future<Either<Failure, CreateCarModel>> createCar({required params}) async {
    if (await networkInfo.isConnected) {
      try {
        CreateCarModel model = await remoteDataSource.createCar(params);

        return Right(model);
      } on ServerException {
        return Left(ServerFailure(message: "Failed! try again "));
      }
    } else {
      return Left(
          NetworkFailure(message: 'Please check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, CarsModel>> fetchCars() async {
    if (await networkInfo.isConnected) {
      try {
        CarsModel model = await remoteDataSource.fetchVehicles();

        return Right(model);
      } on ServerException {
        return Left(ServerFailure(message: "Failed! try again "));
      }
    } else {
      return Left(
          NetworkFailure(message: 'Please check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, CreateCarModel>> deleteCar(params) async {
    if (await networkInfo.isConnected) {
      try {
        CreateCarModel model = await remoteDataSource.deleteCar(params);

        return Right(model);
      } on ServerException {
        return Left(ServerFailure(message: "Failed! try again "));
      }
    } else {
      return Left(
          NetworkFailure(message: 'Please check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, CarModel>> fetchCar(params) async {
    if (await networkInfo.isConnected) {
      try {
        CarModel model = await remoteDataSource.fetchCar(params);

        return Right(model);
      } on ServerException {
        return Left(ServerFailure(message: "Failed! try again "));
      }
    } else {
      return Left(
          NetworkFailure(message: 'Please check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, CreateCarModel>> updateDefault(params) async {
    if (await networkInfo.isConnected) {
      try {
        CreateCarModel model = await remoteDataSource.updateDefault(params);

        return Right(model);
      } on ServerException {
        return Left(ServerFailure(message: "Failed! try again "));
      }
    } else {
      return Left(
          NetworkFailure(message: 'Please check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, CreateCarEntity>> updateCar(params) async {
    if (await networkInfo.isConnected) {
      try {
        CreateCarModel model = await remoteDataSource.updateCar(params);

        return Right(model);
      } on ServerException {
        return Left(ServerFailure(message: "Failed! try again "));
      }
    } else {
      return Left(
          NetworkFailure(message: 'Please check your internet connection'));
    }
  }
}

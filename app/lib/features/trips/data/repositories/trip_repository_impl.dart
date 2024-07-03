import 'package:dartz/dartz.dart';
import 'package:taxialong/core/connection/network_info.dart';
import 'package:taxialong/core/error/execptions.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/features/trips/data/datasources/trip_remote_data_source.dart';
import 'package:taxialong/features/trips/data/models/cancel_model.dart';
import 'package:taxialong/features/trips/data/models/trip_model.dart';
import 'package:taxialong/features/trips/data/models/update_trip_model.dart';
import 'package:taxialong/features/trips/domain/repositories/trip_repository.dart';

class TripRepositoryImpl implements TripRepository {
  final NetworkInfo networkInfo;
  final TripRemoteDataSource remoteDataSource;

  TripRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
  });
  @override
  Future<Either<Failure, TripModel>> getTrip() async {
    if (await networkInfo.isConnected) {
      try {
        TripModel tripModel = await remoteDataSource.getTrip();

        return Right(tripModel);
      } on ServerException {
        return Left(ServerFailure(message: "There is a server failure"));
      }
    } else {
      return Left(
          NetworkFailure(message: 'Please check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, CancelModel>> cancelTrip(params) async {
    if (await networkInfo.isConnected) {
      try {
        CancelModel cancelModel = await remoteDataSource.cancelTrip(params);

        return Right(cancelModel);
      } on ServerException {
        return Left(ServerFailure(message: "There is a server failure"));
      }
    } else {
      return Left(
          NetworkFailure(message: 'Please check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, UpdateTripModel>> updateCompleteTrip() async {
    if (await networkInfo.isConnected) {
      try {
        UpdateTripModel model = await remoteDataSource.updateComplete();

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
  Future<Either<Failure, UpdateTripModel>> updatePickUpTrip() async {
    if (await networkInfo.isConnected) {
      try {
        UpdateTripModel updateTripModel = await remoteDataSource.updatePickUp();

        return Right(updateTripModel);
      } on ServerException {
        return Left(ServerFailure(message: "There is a server failure"));
      }
    } else {
      return Left(
          NetworkFailure(message: 'Please check your internet connection'));
    }
  }
}

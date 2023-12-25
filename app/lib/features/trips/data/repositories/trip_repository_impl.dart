import 'package:dartz/dartz.dart';
import 'package:taxialong/core/connection/network_info.dart';
import 'package:taxialong/core/error/execptions.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/features/trips/data/datasources/trip_remote_data_source.dart';
import 'package:taxialong/features/trips/data/models/trip_model.dart';
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
}

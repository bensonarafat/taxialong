import 'package:dartz/dartz.dart';
import 'package:taxialong/core/connection/network_info.dart';
import 'package:taxialong/core/error/execptions.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/features/rides/data/datasources/ride_remote_data_sources.dart';
import 'package:taxialong/features/rides/data/models/rides_model.dart';
import 'package:taxialong/features/rides/domain/repositories/ride_repository.dart';

class RidesRepositoryImpl implements RideRepository {
  final NetworkInfo networkInfo;
  final RideRemoteDataSource remoteDataSource;
  RidesRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
  });
  @override
  Future<Either<Failure, List<RidesModel>>> getAvailableRides(params) async {
    if (await networkInfo.isConnected) {
      try {
        List<RidesModel> ridesModel =
            await remoteDataSource.getAvaiableRides(params);

        return Right(ridesModel);
      } on ServerException {
        return Left(ServerFailure(message: "There is a server failure"));
      }
    } else {
      return Left(
          NetworkFailure(message: 'Please check your internet connection'));
    }
  }
}

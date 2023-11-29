import 'package:dartz/dartz.dart';
import 'package:taxialong/core/connection/network_info.dart';
import 'package:taxialong/core/error/execptions.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/features/home/data/datasources/home_local_data_source.dart';
import 'package:taxialong/features/home/data/datasources/home_remote_data_source.dart';
import 'package:taxialong/features/home/data/models/axis_model.dart';
import 'package:taxialong/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final NetworkInfo networkInfo;
  final HomeRemoteDataSource remoteDataSource;
  final HomeLocalDataSource localDataSource;
  HomeRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<AxisModel>>> getAxis({required params}) async {
    if (await networkInfo.isConnected) {
      try {
        List<AxisModel> axisModel =
            await remoteDataSource.getAxis(params: params);

        localDataSource.cacheAxis(axisModel);

        return Right(axisModel);
      } on ServerException {
        return Left(ServerFailure(message: "There is a server failure"));
      }
    } else {
      try {
        final localAxis = await localDataSource.getLastCacheAxis();
        return Right(localAxis);
      } catch (_) {
        return Left(
            NetworkFailure(message: 'Please check your internet connection'));
      }
    }
  }
}

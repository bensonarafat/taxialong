import 'package:dartz/dartz.dart';
import 'package:taxialong/core/connection/network_info.dart';
import 'package:taxialong/core/error/execptions.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/features/bus_stops/data/datasources/bus_stop_remote_data_source.dart';
import 'package:taxialong/features/bus_stops/data/models/axis_model.dart';
import 'package:taxialong/features/bus_stops/domain/repositories/bus_stop_repository.dart';

class BusStopRepositoryImpl implements BusStopRepository {
  final NetworkInfo networkInfo;
  final BusStopRemoteDataSource remoteDataSource;

  BusStopRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<AxisModel>>> getBusStops(params) async {
    if (await networkInfo.isConnected) {
      try {
        List<AxisModel> axisModel = await remoteDataSource.fetchBusStop(params);

        return Right(axisModel);
      } on ServerException {
        return Left(ServerFailure(message: "There is a server failure"));
      }
    } else {
      return Left(
          NetworkFailure(message: 'Please check your internet connection'));
    }
  }
}

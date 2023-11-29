import 'package:dartz/dartz.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/features/home/domain/entities/axis_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<AxisEntity>>> getAxis({required params});
  Future<Either<Failure, List<AxisEntity>>> getAxisCached();
}

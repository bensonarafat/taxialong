import 'package:dartz/dartz.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/features/home/domain/entities/axis_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, AxisEntity>> getAxis({required params});
}

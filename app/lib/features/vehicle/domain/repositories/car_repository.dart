import 'package:dartz/dartz.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/features/vehicle/domain/entities/create_car_entity.dart';

abstract class CarRepository {
  Future<Either<Failure, CreateCarEntity>> createCar({required params});
}

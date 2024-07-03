import 'package:dartz/dartz.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/features/vehicle/domain/entities/car_entity.dart';
import 'package:taxialong/features/vehicle/domain/entities/cars_entity.dart';
import 'package:taxialong/features/vehicle/domain/entities/create_car_entity.dart';

abstract class CarRepository {
  Future<Either<Failure, CreateCarEntity>> createCar({required params});
  Future<Either<Failure, CarsEntity>> fetchCars();
  Future<Either<Failure, CreateCarEntity>> deleteCar(params);
  Future<Either<Failure, CreateCarEntity>> updateDefault(params);
  Future<Either<Failure, CarEntity>> fetchCar(params);
  Future<Either<Failure, CreateCarEntity>> updateCar(params);
}

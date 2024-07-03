import 'package:dartz/dartz.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/core/usecases/usecase.dart';
import 'package:taxialong/features/vehicle/domain/entities/cars_entity.dart';
import 'package:taxialong/features/vehicle/domain/repositories/car_repository.dart';

class FetchVehiclesUseCase implements UseCase<CarsEntity, void> {
  CarRepository carRepository;
  FetchVehiclesUseCase({required this.carRepository});

  @override
  Future<Either<Failure, CarsEntity>> call(void params) async {
    return await carRepository.fetchCars();
  }
}

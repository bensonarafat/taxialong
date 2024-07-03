import 'package:dartz/dartz.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/core/usecases/usecase.dart';
import 'package:taxialong/features/vehicle/domain/entities/car_entity.dart';
import 'package:taxialong/features/vehicle/domain/repositories/car_repository.dart';
import 'package:taxialong/features/vehicle/domain/usecases/delete_car_usecase.dart';

class FetchVehicleUseCase implements UseCase<CarEntity, CarParam> {
  CarRepository carRepository;
  FetchVehicleUseCase({required this.carRepository});
  @override
  Future<Either<Failure, CarEntity>> call(CarParam params) async {
    return await carRepository.fetchCar(params);
  }
}

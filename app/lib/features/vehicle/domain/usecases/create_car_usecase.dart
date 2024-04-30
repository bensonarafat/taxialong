import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/core/usecases/usecase.dart';
import 'package:taxialong/features/vehicle/domain/entities/create_car_entity.dart';
import 'package:taxialong/features/vehicle/domain/repositories/car_repository.dart';

class CreateCarUsecase extends UseCase<CreateCarEntity, CarParams> {
  final CarRepository carRepository;
  CreateCarUsecase({
    required this.carRepository,
  });
  @override
  Future<Either<Failure, CreateCarEntity>> call(CarParams params) {
    return carRepository.createCar(params: params);
  }
}

class CarParams extends Equatable {
  final String model;
  final String plateNumber;
  final String color;
  final String seats;

  const CarParams(
      {required this.model,
      required this.plateNumber,
      required this.color,
      required this.seats});
  @override
  List<Object?> get props => [model, plateNumber, color, seats];
}

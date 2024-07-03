import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/core/usecases/usecase.dart';
import 'package:taxialong/features/vehicle/domain/entities/create_car_entity.dart';
import 'package:taxialong/features/vehicle/domain/repositories/car_repository.dart';

class DeleteCarUseCase implements UseCase<CreateCarEntity, CarParam> {
  CarRepository carRepository;

  DeleteCarUseCase({required this.carRepository});
  @override
  Future<Either<Failure, CreateCarEntity>> call(CarParam params) async {
    return await carRepository.deleteCar(params);
  }
}

class CarParam extends Equatable {
  final int id;

  const CarParam({required this.id});

  @override
  List<Object?> get props => [id];
}

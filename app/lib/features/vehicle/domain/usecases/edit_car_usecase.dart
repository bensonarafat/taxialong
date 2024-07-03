import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/core/usecases/usecase.dart';
import 'package:taxialong/features/vehicle/domain/entities/create_car_entity.dart';
import 'package:taxialong/features/vehicle/domain/repositories/car_repository.dart';

class EditCarUseCase implements UseCase<CreateCarEntity, EditCarParams> {
  CarRepository carRepository;
  EditCarUseCase({required this.carRepository});
  @override
  Future<Either<Failure, CreateCarEntity>> call(EditCarParams params) async {
    return await carRepository.updateCar(params);
  }
}

class EditCarParams extends Equatable {
  final int id;
  final String model;
  final String plateNumber;
  final String color;
  final int seatId;
  final List<dynamic> classes;

  const EditCarParams({
    required this.id,
    required this.model,
    required this.plateNumber,
    required this.color,
    required this.seatId,
    required this.classes,
  });
  @override
  List<Object?> get props => [id, model, plateNumber, color, seatId, classes];
}

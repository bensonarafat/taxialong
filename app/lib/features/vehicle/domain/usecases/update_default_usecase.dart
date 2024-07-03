import 'package:dartz/dartz.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/core/usecases/usecase.dart';
import 'package:taxialong/features/vehicle/domain/entities/create_car_entity.dart';
import 'package:taxialong/features/vehicle/domain/repositories/car_repository.dart';
import 'package:taxialong/features/vehicle/domain/usecases/delete_car_usecase.dart';

class UpdateDefaultCarUseCase implements UseCase<CreateCarEntity, CarParam> {
  CarRepository carRepository;
  UpdateDefaultCarUseCase({required this.carRepository});
  @override
  Future<Either<Failure, CreateCarEntity>> call(CarParam params) async {
    return await carRepository.updateDefault(params);
  }
}

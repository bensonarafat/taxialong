import 'package:taxialong/features/vehicle/domain/entities/car_entity.dart';

class CarsEntity {
  final bool status;
  final String message;
  final List<CarEntity>? cars;

  CarsEntity({required this.cars, required this.message, required this.status});
}

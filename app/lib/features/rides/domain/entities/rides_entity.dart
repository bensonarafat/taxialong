import 'package:taxialong/features/rides/domain/entities/driver_entity.dart';
import 'package:taxialong/features/rides/domain/entities/seats_entity.dart';

class RidesEntity {
  final int rideClass;
  final String paymentMethod;
  final int amount;
  final SeatsEntity? seatsEntity;
  final DriverEntity driverEntity;

  RidesEntity({
    required this.rideClass,
    required this.paymentMethod,
    required this.amount,
    required this.seatsEntity,
    required this.driverEntity,
  });
}

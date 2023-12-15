import 'package:taxialong/features/rides/data/models/driver_model.dart';
import 'package:taxialong/features/rides/domain/entities/rides_entity.dart';

class RidesModel extends RidesEntity {
  RidesModel({
    required super.rideClass,
    required super.paymentMethod,
    required super.amount,
    required super.seatsEntity,
    required super.driverEntity,
  });

  factory RidesModel.fromJson(Map<String, dynamic> json) {
    return RidesModel(
      rideClass: json['class'],
      paymentMethod: json['payment_method'],
      amount: json['amount'],
      seatsEntity: null,
      driverEntity: DriverModel.fromJson(json['driver']),
    );
  }
}

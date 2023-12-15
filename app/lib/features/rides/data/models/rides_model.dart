import 'package:taxialong/features/rides/data/models/driver_model.dart';
import 'package:taxialong/features/rides/data/models/seats_model.dart';
import 'package:taxialong/features/rides/domain/entities/rides_entity.dart';

class RidesModel extends RidesEntity {
  RidesModel({
    required super.rideClass,
    required super.paymentMethod,
    required super.amount,
    required super.seats,
    required super.driver,
  });

  factory RidesModel.fromJson(Map<String, dynamic> json) {
    List<SeatsModel>? seats;
    if (json['seats'] != null) {
      List<dynamic> seats = json['seats'];
      seats = seats.map((item) => SeatsModel.fromJson(item)).toList();
    }
    return RidesModel(
      rideClass: json['class'],
      paymentMethod: json['payment_method'],
      amount: json['amount'],
      seats: seats,
      driver: DriverModel.fromJson(json['driver']),
    );
  }
}

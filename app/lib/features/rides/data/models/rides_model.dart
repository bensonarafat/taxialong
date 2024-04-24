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
    required super.pointa,
    required super.pointb,
  });

  factory RidesModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> driverseats = json['seats'];
    List<SeatsModel> seats =
        driverseats.map((item) => SeatsModel.fromJson(item)).toList();

    return RidesModel(
      rideClass: json['class'],
      paymentMethod: json['payment_method'],
      amount: json['amount'],
      seats: seats,
      driver: DriverModel.fromJson(json['driver']),
      pointa: json['pointa'],
      pointb: json['pointb'],
    );
  }
}

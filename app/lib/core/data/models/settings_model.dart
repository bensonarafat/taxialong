import 'package:taxialong/core/domain/entities/settings_entity.dart';

class SettingsModel extends SettingsEntity {
  SettingsModel({
    required super.id,
    required super.userId,
    required super.driverId,
    required super.pointa,
    required super.pointb,
    required super.rideclass,
    required super.paymentMethod,
  });

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      id: json['id'],
      userId: json['user_id'],
      driverId: json['driver_id'],
      pointa: json['pointa'],
      pointb: json['pointb'],
      rideclass: json['ride_class'],
      paymentMethod: json['payment_method'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user_id": userId,
      "driver_id": driverId,
      "pointa": pointa,
      "pointb": pointb,
      "ride_class": rideclass,
      "payment_method": paymentMethod,
    };
  }
}

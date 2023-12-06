import 'package:taxialong/features/driver/domain/entities/settings_entity.dart';

class SettingsModel extends SettingsEntity {
  SettingsModel({
    required super.id,
    required super.userId,
    required super.driverId,
    required super.pointa,
    required super.pointb,
    required super.rideclass,
  });

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      id: json['id'],
      userId: json['user_id'],
      driverId: json['driver_id'],
      pointa: json['pointa'],
      pointb: json['pointb'],
      rideclass: json['ride_class'],
    );
  }
}

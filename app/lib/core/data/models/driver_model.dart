import 'package:taxialong/core/domain/entities/driver_entity.dart';

class DriverModel extends DriverEntity {
  DriverModel({
    required super.userId,
    required super.online,
    required super.latitude,
    required super.longitude,
  });

  factory DriverModel.fromJson(Map<String, dynamic> json) {
    return DriverModel(
      userId: json['user_id'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      online: json['online'],
    );
  }
}

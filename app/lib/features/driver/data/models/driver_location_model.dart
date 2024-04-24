import 'package:taxialong/features/driver/domain/entities/driver_location_entity.dart';

class DriverLocationModel extends DriverLocationEntity {
  DriverLocationModel({required super.status, required super.message});

  factory DriverLocationModel.fromJson(Map<String, dynamic> json) {
    return DriverLocationModel(
      status: json['status'],
      message: json['message'],
    );
  }
}

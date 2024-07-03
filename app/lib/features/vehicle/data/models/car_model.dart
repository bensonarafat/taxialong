import 'dart:convert';

import 'package:taxialong/features/vehicle/domain/entities/car_entity.dart';

class CarModel extends CarEntity {
  CarModel({
    required super.id,
    required super.userId,
    required super.seatId,
    required super.color,
    required super.createdAt,
    required super.driverId,
    required super.isDefault,
    required super.model,
    required super.plateNumber,
    required super.status,
    required super.updatedAt,
    required super.seats,
    required super.classes,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    List<dynamic>? seats;
    List<dynamic>? classes;
    if (json['seats'] != null) {
      seats = jsonDecode(json['seats']);
    }
    if (json['classes'] != null) {
      classes = jsonDecode(json['classes']);
    }
    return CarModel(
      id: json['id'],
      userId: json['user_id'],
      seatId: json['seatId'],
      color: json['color'],
      createdAt: json['created_at'],
      driverId: json['driver_id'],
      isDefault: json['default'],
      model: json['model'],
      plateNumber: json['plate_number'],
      status: json['status'],
      updatedAt: json['updated_at'],
      seats: seats,
      classes: classes,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user_id": userId,
      "seatId": seatId,
      "color": color,
      "created_at": createdAt,
      "updated_at": updatedAt,
      "driver_id": driverId,
      "default": isDefault,
      "plate_number": plateNumber,
      "status": status,
      "seats": seats,
      "classes": classes,
    };
  }
}

import 'package:taxialong/features/rides/domain/entities/confirm_ride_entity.dart';

class ConfirmRideModel extends ConfirmRideEntity {
  ConfirmRideModel({
    required super.status,
    required super.message,
  });

  factory ConfirmRideModel.fromJson(Map<String, dynamic> json) {
    return ConfirmRideModel(
      status: json['status'],
      message: json['message'],
    );
  }
}

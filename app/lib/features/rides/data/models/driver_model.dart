import 'package:taxialong/features/rides/domain/entities/driver_entity.dart';

class DriverModel extends DriverEntity {
  DriverModel({
    required super.firstname,
    required super.lastname,
    required super.email,
    required super.telephone,
    required super.avatar,
    required super.rating,
    required super.verified,
  });

  factory DriverModel.fromJson(Map<String, dynamic> json) {
    return DriverModel(
      firstname: json['firstname'],
      lastname: json["lastname"],
      email: json['email'],
      telephone: json['telephone'],
      avatar: json['avatar'],
      rating: json['rating'],
      verified: json['verified'],
    );
  }
}

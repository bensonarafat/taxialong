import 'package:taxialong/features/driver/domain/entities/rider_entity.dart';

class RiderModel extends RiderEntity {
  RiderModel({
    required super.id,
    required super.firstname,
    required super.lastname,
    required super.email,
    required super.telephone,
    required super.avatar,
    required super.rating,
    required super.verified,
  });

  factory RiderModel.fromJson(Map<String, dynamic> json) {
    return RiderModel(
      id: json['id'],
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

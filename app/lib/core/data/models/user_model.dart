import 'package:taxialong/core/data/models/driver_model.dart';
import 'package:taxialong/core/data/models/settings_model.dart';
import 'package:taxialong/core/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.firstname,
    required super.lastname,
    required super.email,
    required super.telephone,
    required super.avatar,
    required super.rating,
    required super.verified,
    required super.role,
    required super.documentCount,
    required super.settings,
    required super.driver,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    DriverModel? driver;

    if (json['driver'] != null) {
      driver = DriverModel.fromJson(json['driver']);
    }
    return UserModel(
      id: json['id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      telephone: json['telephone'],
      avatar: json['avatar'],
      rating: json['rating'],
      verified: json['verified'],
      role: json['role'],
      documentCount: json['documents_count'],
      settings: SettingsModel.fromJson(json['settings']),
      driver: driver,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "firstname": firstname,
      "lastname": lastname,
      "email": email,
      "telephone": telephone,
      "avatar": avatar,
      "rating": rating,
      "verified": verified,
      "role": role,
      "documents_count": documentCount,
      "settings": settings,
      "driver": driver,
    };
  }
}

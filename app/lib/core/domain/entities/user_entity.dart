import 'package:taxialong/core/domain/entities/driver_entity.dart';
import 'package:taxialong/core/domain/entities/settings_entity.dart';

class UserEntity {
  final int id;
  final String firstname;
  final String lastname;
  final String email;
  final String telephone;
  final String avatar;
  final String rating;
  final String verified;
  final String role;
  final String? documentCount;
  final SettingsEntity? settings;
  final DriverEntity? driver;

  UserEntity({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.telephone,
    required this.avatar,
    required this.rating,
    required this.verified,
    required this.role,
    required this.documentCount,
    required this.settings,
    required this.driver,
  });
}

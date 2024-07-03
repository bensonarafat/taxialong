import 'package:taxialong/core/domain/entities/settings_entity.dart';

class LocationEntity {
  final int id;
  final int userId;
  final int online;
  final double? latitude;
  final double? longitude;
  final SettingsEntity? settings;

  LocationEntity({
    required this.id,
    required this.userId,
    required this.online,
    required this.latitude,
    required this.longitude,
    required this.settings,
  });
}

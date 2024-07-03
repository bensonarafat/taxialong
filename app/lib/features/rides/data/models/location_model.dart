import 'package:taxialong/core/data/models/settings_model.dart';
import 'package:taxialong/features/rides/domain/entities/location_entity.dart';

class LocationModel extends LocationEntity {
  LocationModel({
    required super.id,
    required super.userId,
    required super.online,
    required super.latitude,
    required super.longitude,
    required super.settings,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    SettingsModel? settings;
    if (json['trip_driver'] != null) {
      settings = SettingsModel.fromJson(json['settings']);
    }
    return LocationModel(
      id: json['id'],
      userId: json['user_id'],
      online: json['online'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      settings: settings,
    );
  }
}

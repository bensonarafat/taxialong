import 'package:taxialong/features/rides/domain/entities/location_entity.dart';

class LocationModel extends LocationEntity {
  LocationModel({
    required super.id,
    required super.userId,
    required super.online,
    required super.latitude,
    required super.longitude,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'],
      userId: json['user_id'],
      online: json['online'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}

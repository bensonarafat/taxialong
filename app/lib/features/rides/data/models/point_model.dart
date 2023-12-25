import 'package:taxialong/features/rides/domain/entities/point_entity.dart';

class PointModel extends PointEntity {
  PointModel({
    required super.id,
    required super.name,
    required super.latitude,
    required super.longitude,
  });

  factory PointModel.fromJson(Map<String, dynamic> json) {
    return PointModel(
        id: json['id'],
        name: json['name'],
        latitude: json['latitude'],
        longitude: json['longitude']);
  }
}

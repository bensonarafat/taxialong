import 'package:taxialong/core/data/models/settings_model.dart';
import 'package:taxialong/core/data/models/user_model.dart';
import 'package:taxialong/features/rides/domain/entities/rides_entity.dart';
import 'package:taxialong/features/vehicle/data/models/car_model.dart';

class RidesModel extends RidesEntity {
  RidesModel({
    required super.id,
    required super.latitude,
    required super.longitude,
    required super.distance,
    required super.settings,
    required super.car,
    required super.user,
    required super.classes,
    required super.pointa,
    required super.pointb,
  });

  factory RidesModel.fromJson(Map<String, dynamic> json) {
    return RidesModel(
      id: json['id'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      distance: json['distance'],
      settings: SettingsModel.fromJson(json['settings']),
      car: CarModel.fromJson(json['car']),
      user: UserModel.fromJson(json['user']),
      classes: json['classes'],
      pointa: json['pointa'],
      pointb: json['pointb'],
    );
  }
}

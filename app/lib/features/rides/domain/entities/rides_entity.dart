import 'package:taxialong/core/domain/entities/settings_entity.dart';
import 'package:taxialong/core/domain/entities/user_entity.dart';
import 'package:taxialong/features/vehicle/domain/entities/car_entity.dart';

class RidesEntity {
  final int id;
  final double? latitude;
  final double? longitude;
  final dynamic distance;
  final int pointa;
  final int pointb;
  final SettingsEntity settings;
  final CarEntity car;
  final List<dynamic> classes;
  final UserEntity user;

  RidesEntity({
    required this.id,
    required this.pointa,
    required this.pointb,
    required this.latitude,
    required this.longitude,
    required this.car,
    required this.distance,
    required this.settings,
    required this.user,
    required this.classes,
  });
}

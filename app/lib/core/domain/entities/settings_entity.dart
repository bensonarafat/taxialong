import 'package:taxialong/features/rides/domain/entities/point_entity.dart';

class SettingsEntity {
  final int id;
  final int userId;
  final int? driverId;
  final int? pointa;
  final int? pointb;
  final String paymentMethod;
  final PointEntity? origin;
  final PointEntity? destination;

  SettingsEntity({
    required this.id,
    required this.userId,
    required this.driverId,
    required this.pointa,
    required this.pointb,
    required this.paymentMethod,
    required this.destination,
    required this.origin,
  });
}

import 'package:taxialong/core/domain/entities/settings_entity.dart';
import 'package:taxialong/features/rides/data/models/point_model.dart';

class SettingsModel extends SettingsEntity {
  SettingsModel({
    required super.id,
    required super.userId,
    required super.driverId,
    required super.pointa,
    required super.pointb,
    required super.paymentMethod,
    required super.origin,
    required super.destination,
  });

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    PointModel? origin;
    if (json['trip_driver'] != null) {
      origin = PointModel.fromJson(json['origin']);
    }
    PointModel? destination;
    if (json['trip_driver'] != null) {
      origin = PointModel.fromJson(json['destination']);
    }
    return SettingsModel(
      id: json['id'],
      userId: json['user_id'],
      driverId: json['driver_id'],
      pointa: json['pointa'],
      pointb: json['pointb'],
      paymentMethod: json['payment_method'],
      origin: origin,
      destination: destination,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user_id": userId,
      "driver_id": driverId,
      "pointa": pointa,
      "pointb": pointb,
      "payment_method": paymentMethod,
    };
  }
}

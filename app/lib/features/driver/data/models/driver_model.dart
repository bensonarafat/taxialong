import 'package:taxialong/core/data/models/user_model.dart';
import 'package:taxialong/features/driver/data/models/settings_model.dart';
import 'package:taxialong/features/driver/domain/entities/driver_entity.dart';

class DriverModel extends DriverEntity {
  DriverModel({
    required super.status,
    required super.message,
    required super.userId,
    required super.online,
    required super.latitude,
    required super.longitude,
    required super.earningsCount,
    required super.totalRidesCount,
    required super.todayRideCount,
    required super.earningSumAmount,
    required super.user,
    required super.settings,
  });

  factory DriverModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> data = json['data'];
    return DriverModel(
      userId: data['user_id'],
      latitude: data['latitude'],
      longitude: data['longitude'],
      earningsCount: data['earnings_count'],
      totalRidesCount: data['total_rides_count'],
      todayRideCount: data['today_ride_count'],
      earningSumAmount: data['earnings_sum_amount'],
      user: UserModel.fromJson(data['user']),
      settings: SettingsModel.fromJson(data['settings']),
      status: json['status'],
      message: json['message'],
      online: data['online'],
    );
  }
}

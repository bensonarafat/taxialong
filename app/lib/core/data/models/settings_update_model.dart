import 'package:taxialong/core/domain/entities/settings_update_entity.dart';

class SettingsUpdateModel extends SettingsUpdateEntity {
  SettingsUpdateModel({required super.status, required super.message});

  factory SettingsUpdateModel.fromJson(Map<String, dynamic> json) {
    return SettingsUpdateModel(
      status: json['status'],
      message: json['message'],
    );
  }
}

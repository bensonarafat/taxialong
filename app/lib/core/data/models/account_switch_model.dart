import 'package:taxialong/core/domain/entities/account_switch_entity.dart';

class AccountSwitchModel extends AccountSwitchEntity {
  AccountSwitchModel({required super.status, required super.message});

  factory AccountSwitchModel.fromJson(Map<String, dynamic> json) {
    return AccountSwitchModel(status: json['status'], message: json['message']);
  }

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "message": message,
    };
  }
}

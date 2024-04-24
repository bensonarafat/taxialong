import 'package:taxialong/features/auth/domain/entities/logout_entity.dart';

class LogoutModel extends LogoutEntity {
  LogoutModel(
      {required super.status, required super.response, required super.message});

  factory LogoutModel.fromJson(Map<String, dynamic> json) {
    return LogoutModel(
      status: json['status'],
      response: json['response'],
      message: json['message'],
    );
  }
}

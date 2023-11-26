import 'package:taxialong/features/auth/domain/entities/auth_entity.dart';

class AuthModel extends AuthEntity {
  AuthModel({
    required super.token,
    required super.expiresIn,
    required super.status,
    required super.message,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      token: json['access_token'],
      expiresIn: json['expires_in'],
      status: json['status'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {};
  }
}

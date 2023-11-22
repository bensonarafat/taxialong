import 'package:taxialong/features/auth/domain/entities/login_entity.dart';

class LoginModel extends LoginEntity {
  LoginModel({
    required super.token,
    required super.expiresIn,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(token: json['token'], expiresIn: json['expires_in']);
  }

  Map<String, dynamic> toJson() {
    return {};
  }
}

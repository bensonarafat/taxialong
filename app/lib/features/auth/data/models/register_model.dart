import 'package:taxialong/features/auth/domain/entities/register_entity.dart';

class RegisterModel extends RegisterEntity {
  RegisterModel({
    required super.otp,
    required super.telephone,
    required super.uuid,
    required super.expires,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      otp: json['otp'],
      telephone: json['telephone'],
      uuid: json['uuid'],
      expires: json['expires'],
    );
  }

  Map<String, dynamic> toJson() {
    return {};
  }
}

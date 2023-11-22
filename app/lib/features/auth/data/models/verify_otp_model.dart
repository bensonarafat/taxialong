import 'package:taxialong/features/auth/domain/entities/otp_entity.dart';

class VerifyOTPModel extends OTPEntity {
  VerifyOTPModel({
    required super.otp,
    required super.uuid,
    required super.telephone,
  });

  factory VerifyOTPModel.fromJson(Map<String, dynamic> json) {
    return VerifyOTPModel(
      otp: json['otp'],
      uuid: json['uuid'],
      telephone: json['telephone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {};
  }
}

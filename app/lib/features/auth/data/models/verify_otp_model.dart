import 'package:taxialong/features/auth/domain/entities/otp_entity.dart';

class VerifyOTPModel extends OTPEntity {
  VerifyOTPModel({
    required super.otp,
    required super.uuid,
    required super.telephone,
    required super.message,
    required super.status,
  });

  factory VerifyOTPModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic>? data = json['data'];
    return VerifyOTPModel(
      otp: data == null ? '' : data['otp'],
      uuid: data == null ? '' : data['uuid'],
      telephone: data == null ? '' : data['telephone'],
      message: json['message'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {};
  }
}

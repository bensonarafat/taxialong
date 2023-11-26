import 'package:taxialong/features/auth/domain/entities/telephone_entity.dart';

class TelephoneModel extends TelephoneEntity {
  TelephoneModel({
    required super.otp,
    required super.telephone,
    required super.uuid,
    required super.expires,
    required super.message,
    required super.status,
    required super.handler,
  });

  factory TelephoneModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic>? data = json['data'];
    return TelephoneModel(
      otp: data == null ? '' : data['otp'],
      telephone: data == null ? '' : data['telephone'],
      uuid: data == null ? '' : data['uuid'],
      expires: data == null ? '' : data['expires'],
      message: json['message'],
      status: json['status'],
      handler: json['handler'],
    );
  }

  Map<String, dynamic> toJson() {
    return {};
  }
}

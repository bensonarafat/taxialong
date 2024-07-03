// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_auth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyAuthModel _$VerifyAuthModelFromJson(Map<String, dynamic> json) =>
    VerifyAuthModel(
      status: json['status'] as bool,
      message: json['message'] as String,
      isDriver: json['is_driver'] as bool?,
      isTrip: json['is_trip'] as bool?,
    );

Map<String, dynamic> _$VerifyAuthModelToJson(VerifyAuthModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'is_driver': instance.isDriver,
      'is_trip': instance.isTrip,
    };

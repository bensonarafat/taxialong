// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthModel _$AuthModelFromJson(Map<String, dynamic> json) => AuthModel(
      token: json['access_token'] as String,
      expiresIn: json['expires_in'] as int,
      status: json['status'] as bool,
      message: json['message'] as String,
      role: json['role'] as String,
    );

Map<String, dynamic> _$AuthModelToJson(AuthModel instance) => <String, dynamic>{
      'access_token': instance.token,
      'expires_in': instance.expiresIn,
      'message': instance.message,
      'status': instance.status,
      'role': instance.role,
    };

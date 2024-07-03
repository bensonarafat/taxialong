import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:taxialong/features/auth/domain/entities/auth_entity.dart';

part 'auth_model.g.dart';

@JsonSerializable()
class AuthModel extends AuthEntity {
  AuthModel({
    required super.token,
    required super.expiresIn,
    required super.status,
    required super.message,
    required super.role,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) =>
      _$AuthModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthModelToJson(this);
}

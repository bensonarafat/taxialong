import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:taxialong/features/auth/domain/entities/verify_auth_entity.dart';

part 'verify_auth_model.g.dart';

@JsonSerializable()
class VerifyAuthModel extends VerifyAuthEntity {
  VerifyAuthModel(
      {required super.status,
      required super.message,
      required super.isDriver,
      required super.isTrip});

  factory VerifyAuthModel.fromJson(Map<String, dynamic> json) =>
      _$VerifyAuthModelFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyAuthModelToJson(this);
}

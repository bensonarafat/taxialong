import 'package:freezed_annotation/freezed_annotation.dart';

class AuthEntity {
  @JsonKey(name: "access_token")
  final String token;
  @JsonKey(name: "expires_in")
  final int expiresIn;
  final String message;
  final bool status;
  final String role;

  AuthEntity({
    required this.token,
    required this.expiresIn,
    required this.status,
    required this.message,
    required this.role,
  });
}

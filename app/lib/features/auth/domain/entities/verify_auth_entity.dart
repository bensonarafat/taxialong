import 'package:freezed_annotation/freezed_annotation.dart';

class VerifyAuthEntity {
  final bool status;
  final String message;
  @JsonKey(name: "is_driver")
  final bool? isDriver;
  @JsonKey(name: "is_trip")
  final bool? isTrip;

  VerifyAuthEntity({
    required this.status,
    required this.message,
    required this.isDriver,
    required this.isTrip,
  });
}

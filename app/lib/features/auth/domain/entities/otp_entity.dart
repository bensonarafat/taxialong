class OTPEntity {
  final String otp;
  final String uuid;
  final String telephone;
  final bool status;
  final String message;

  OTPEntity({
    required this.otp,
    required this.uuid,
    required this.telephone,
    required this.status,
    required this.message,
  });
}

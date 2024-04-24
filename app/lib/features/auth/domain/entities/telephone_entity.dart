class TelephoneEntity {
  final int otp;
  final String telephone;
  final String uuid;
  final String expires;
  final String message;
  final bool status;
  final String handler;

  TelephoneEntity({
    required this.otp,
    required this.telephone,
    required this.uuid,
    required this.expires,
    required this.message,
    required this.status,
    required this.handler,
  });
}

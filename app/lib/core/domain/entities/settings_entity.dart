class SettingsEntity {
  final int id;
  final String userId;
  final String driverId;
  final String? pointa;
  final String? pointb;
  final List<Map<String, dynamic>>? rideclass;
  final String paymentMethod;

  SettingsEntity({
    required this.id,
    required this.userId,
    required this.driverId,
    required this.pointa,
    required this.pointb,
    required this.rideclass,
    required this.paymentMethod,
  });
}

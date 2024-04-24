class DriverEntity {
  final String message;
  final bool status;
  final String userId;
  final String online;
  final String? latitude;
  final String? longitude;
  final String earningsCount;
  final String totalRidesCount;
  final String todayRideCount;
  final String? earningSumAmount;

  DriverEntity({
    required this.message,
    required this.status,
    required this.online,
    required this.userId,
    required this.latitude,
    required this.longitude,
    required this.earningsCount,
    required this.totalRidesCount,
    required this.todayRideCount,
    required this.earningSumAmount,
  });
}

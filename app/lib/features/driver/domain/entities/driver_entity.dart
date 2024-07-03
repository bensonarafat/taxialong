class DriverEntity {
  final String message;
  final bool status;
  final int userId;
  final int online;
  final double? latitude;
  final double? longitude;
  final int earningsCount;
  final int totalRidesCount;
  final int todayRideCount;
  final double? earningSumAmount;

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

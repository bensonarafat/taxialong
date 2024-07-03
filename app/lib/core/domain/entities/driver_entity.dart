class DriverEntity {
  final int userId;
  final int online;
  final double? latitude;
  final double? longitude;
  DriverEntity({
    required this.online,
    required this.userId,
    required this.latitude,
    required this.longitude,
  });
}

class DriverEntity {
  final String userId;
  final String online;
  final String? latitude;
  final String? longitude;
  DriverEntity({
    required this.online,
    required this.userId,
    required this.latitude,
    required this.longitude,
  });
}

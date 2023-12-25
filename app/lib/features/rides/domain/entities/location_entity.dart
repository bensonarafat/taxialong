class LocationEntity {
  final int id;
  final int userId;
  final int online;
  final String latitude;
  final String longitude;

  LocationEntity({
    required this.id,
    required this.userId,
    required this.online,
    required this.latitude,
    required this.longitude,
  });
}

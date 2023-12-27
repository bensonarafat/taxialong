class LocationEntity {
  final int id;
  final String userId;
  final String online;
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

class SeatsEntity {
  final int id;
  final String name;
  final int total;
  final List<dynamic> seats;
  final List<dynamic>? classes;

  SeatsEntity({
    required this.id,
    required this.name,
    required this.seats,
    required this.total,
    required this.classes,
  });
}

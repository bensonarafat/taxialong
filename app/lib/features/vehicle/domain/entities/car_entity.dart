class CarEntity {
  final int id;
  final int userId;

  final int seatId;
  final String color;
  final String plateNumber;

  final String model;

  final int status;

  final int isDefault;

  final int? driverId;

  final String createdAt;

  final String updatedAt;

  final List<dynamic>? seats;

  final List<dynamic>? classes;

  CarEntity({
    required this.id,
    required this.userId,
    required this.seatId,
    required this.color,
    required this.createdAt,
    required this.driverId,
    required this.isDefault,
    required this.model,
    required this.plateNumber,
    required this.status,
    required this.updatedAt,
    required this.seats,
    required this.classes,
  });
}

import 'package:taxialong/features/rides/domain/entities/trip_entity.dart';

class ConfirmRideEntity {
  final bool status;
  final String message;
  final TripEntity? trip;

  ConfirmRideEntity({
    required this.status,
    required this.message,
    required this.trip,
  });
}

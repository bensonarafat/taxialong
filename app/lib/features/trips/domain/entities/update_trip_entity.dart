import 'package:taxialong/features/trips/data/models/trip_model.dart';

class UpdateTripEntity {
  final bool status;
  final String message;
  final TripModel? trip;

  UpdateTripEntity({
    required this.status,
    required this.message,
    required this.trip,
  });
}

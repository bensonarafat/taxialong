part of 'trip_bloc.dart';

@immutable
abstract class TripEvent extends Equatable {}

class GetTripEvent extends TripEvent {
  @override
  List<Object?> get props => [];
}

class CancelTripEvent extends TripEvent {
  final String tripId;
  final String reason;

  CancelTripEvent({required this.tripId, required this.reason});
  @override
  List<Object?> get props => [tripId, reason];
}

class UpdatePickUpEvent extends TripEvent {
  @override
  List<Object?> get props => [];
}

class UpdateCompletedEvent extends TripEvent {
  @override
  List<Object?> get props => [];
}

part of 'cancel_bloc.dart';

abstract class CancelEvent extends Equatable {}

class CancelTripEvent extends CancelEvent {
  final String tripId;
  final String reason;

  CancelTripEvent({required this.tripId, required this.reason});
  @override
  List<Object?> get props => [tripId, reason];
}

part of 'trip_bloc.dart';

@immutable
abstract class TripEvent extends Equatable {}

class GetTripEvent extends TripEvent {
  @override
  List<Object?> get props => [];
}

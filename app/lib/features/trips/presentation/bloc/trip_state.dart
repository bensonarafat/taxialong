part of 'trip_bloc.dart';

@immutable
abstract class TripState extends Equatable {}

class TripInit extends TripState {
  @override
  List<Object?> get props => [];
}

class TripLoadingState extends TripState {
  @override
  List<Object?> get props => [];
}

class TripErrorState extends TripState {
  final String message;

  TripErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class UpdateCompleteState extends TripState {
  final UpdateTripEntity tripEntity;

  UpdateCompleteState({required this.tripEntity});

  @override
  List<Object?> get props => [tripEntity];
}

class UpdatePickUpState extends TripState {
  final UpdateTripEntity updateTripEntity;

  UpdatePickUpState({required this.updateTripEntity});

  @override
  List<Object?> get props => [updateTripEntity];
}

class CurrentTripState extends TripState {
  final TripEntity trip;

  CurrentTripState({required this.trip});

  @override
  List<Object?> get props => [trip];
}

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

class TripLoadedState extends TripState {
  final TripEntity tripEntity;

  TripLoadedState({required this.tripEntity});

  @override
  List<Object?> get props => [tripEntity];
}

class TripErrorState extends TripState {
  final String message;

  TripErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class TripCancelState extends TripState {
  final CancelEntity cancelEntity;
  TripCancelState({required this.cancelEntity});
  @override
  List<Object?> get props => [cancelEntity];
}

class UpdateCompleteState extends TripState {
  final UpdateTripEntity updateTripEntity;

  UpdateCompleteState({required this.updateTripEntity});

  @override
  List<Object?> get props => [updateTripEntity];
}

class UpdatePickUpState extends TripState {
  final UpdateTripEntity updateTripEntity;

  UpdatePickUpState({required this.updateTripEntity});

  @override
  List<Object?> get props => [updateTripEntity];
}

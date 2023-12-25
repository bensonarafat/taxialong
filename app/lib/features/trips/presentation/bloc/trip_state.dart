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

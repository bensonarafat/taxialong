part of 'map_bloc.dart';

@immutable
abstract class MapState extends Equatable {}

class MapInitialState extends MapState {
  @override
  List<Object?> get props => [];
}

class MapErrorState extends MapState {
  @override
  List<Object?> get props => [];
}

class MapLoadedState extends MapState {
  @override
  List<Object?> get props => [];
}

class MapCurrentPositionState extends MapState {
  final String latitude;
  final String longitude;

  MapCurrentPositionState({required this.latitude, required this.longitude});
  @override
  List<Object?> get props => [latitude, longitude];
}

class DriverLocationUpdatedState extends MapState {
  final String latitude;
  final String longitude;

  DriverLocationUpdatedState({required this.latitude, required this.longitude});
  @override
  List<Object?> get props => [latitude, longitude];
}

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
  final double latitude;
  final double longitude;

  MapCurrentPositionState({required this.latitude, required this.longitude});
  @override
  List<Object?> get props => [latitude, longitude];
}

class DriverLocationUpdatedState extends MapState {
  final double latitude;
  final double longitude;
  final Set<Marker> markers;

  DriverLocationUpdatedState(
      {required this.latitude, required this.longitude, required this.markers});
  @override
  List<Object?> get props => [latitude, longitude, markers];
}

class TripOnGoingState extends MapState {
  @override
  List<Object?> get props => [];
}

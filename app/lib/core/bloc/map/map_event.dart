part of 'map_bloc.dart';

@immutable
abstract class MapEvent extends Equatable {}

class MapCurrentPositionEvent extends MapEvent {
  @override
  List<Object?> get props => [];
}

class MapUpdateCurrentPostionEvent extends MapEvent {
  final double latitude;
  final double longitude;

  MapUpdateCurrentPostionEvent(
      {required this.latitude, required this.longitude});
  @override
  List<Object?> get props => [latitude, longitude];
}

class UpdatePickUpMapEvent extends MapEvent {
  @override
  List<Object?> get props => [];
}

class DriverUpdateLocationEvent extends MapEvent {
  final double latitude;
  final double longitude;

  DriverUpdateLocationEvent({required this.latitude, required this.longitude});
  @override
  List<Object?> get props => [latitude, longitude];
}

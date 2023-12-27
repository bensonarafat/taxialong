part of 'map_bloc.dart';

@immutable
abstract class MapEvent extends Equatable {}

class MapCurrentPositionEvent extends MapEvent {
  @override
  List<Object?> get props => [];
}

class MapUpdateCurrentPostionEvent extends MapEvent {
  final String latitude;
  final String longitude;

  MapUpdateCurrentPostionEvent(
      {required this.latitude, required this.longitude});
  @override
  List<Object?> get props => [latitude, longitude];
}

class SubscribeToDriverChannel extends MapEvent {
  final String driverId;

  SubscribeToDriverChannel({required this.driverId});

  @override
  List<Object?> get props => [driverId];
}

class SubscribeToTripChannel extends MapEvent {
  final String driverId;

  SubscribeToTripChannel({required this.driverId});
  @override
  List<Object?> get props => [driverId];
}

class PusherUpdateLocationEvent extends MapEvent {
  final String latitude;
  final String longitude;

  PusherUpdateLocationEvent({required this.latitude, required this.longitude});
  @override
  List<Object?> get props => [latitude, longitude];
}

class PusherTripUpdateEevnt extends MapEvent {
  @override
  List<Object?> get props => [];
}

class UpdatePickUpMapEvent extends MapEvent {
  @override
  List<Object?> get props => [];
}

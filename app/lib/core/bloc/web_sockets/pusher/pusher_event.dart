part of 'pusher_bloc.dart';

@immutable
abstract class PusherEvent extends Equatable {}

class PusherUpdateLocationEvent extends PusherEvent {
  final double latitude;
  final double longitude;

  PusherUpdateLocationEvent({required this.latitude, required this.longitude});
  @override
  List<Object?> get props => [latitude, longitude];
}

class SubscribeToDriverChannel extends PusherEvent {
  final int driverId;

  SubscribeToDriverChannel({required this.driverId});

  @override
  List<Object?> get props => [driverId];
}

class SubscribeToTripChannel extends PusherEvent {
  final String driverId;

  SubscribeToTripChannel({required this.driverId});
  @override
  List<Object?> get props => [driverId];
}

class PusherTripUpdateEvent extends PusherEvent {
  @override
  List<Object?> get props => [];
}

part of 'pusher_bloc.dart';

@immutable
abstract class PusherState extends Equatable {}

class PusherInitState extends PusherState {
  @override
  List<Object?> get props => [];
}

class PusherTripUpdateState extends PusherState {
  @override
  List<Object?> get props => [];
}

class PusherUpdateLocationState extends PusherState {
  final String latitude;
  final String longitude;

  PusherUpdateLocationState({required this.latitude, required this.longitude});

  @override
  List<Object?> get props => [latitude, longitude];
}

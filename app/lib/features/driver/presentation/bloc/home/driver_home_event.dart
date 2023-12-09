part of 'driver_home_bloc.dart';

@immutable
abstract class DriverHomeEvent extends Equatable {}

class DriverHomeGoOnlineEvent extends DriverHomeEvent {
  @override
  List<Object?> get props => [];
}

class DriverHomeFetchEvent extends DriverHomeEvent {
  @override
  List<Object?> get props => [];
}

class DriverUpdateLocationEvent extends DriverHomeEvent {
  final String latitude;
  final String longitude;

  DriverUpdateLocationEvent({required this.latitude, required this.longitude});
  @override
  List<Object?> get props => [latitude, longitude];
}

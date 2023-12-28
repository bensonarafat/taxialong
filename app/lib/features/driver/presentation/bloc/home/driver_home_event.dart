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

class DriverHomeFetchRecents extends DriverHomeEvent {
  final bool loading;

  DriverHomeFetchRecents({required this.loading});

  @override
  List<Object?> get props => [loading];
}

class DriverHomeFetchRequests extends DriverHomeEvent {
  final bool loading;

  DriverHomeFetchRequests({required this.loading});
  @override
  List<Object?> get props => [loading];
}

class DriverHomeUpdateLocationEvent extends DriverHomeEvent {
  final String latitude;
  final String longitude;

  DriverHomeUpdateLocationEvent(
      {required this.latitude, required this.longitude});
  @override
  List<Object?> get props => [latitude, longitude];
}

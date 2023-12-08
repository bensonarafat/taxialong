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

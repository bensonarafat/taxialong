part of 'driver_home_bloc.dart';

@immutable
abstract class DriverHomeState extends Equatable {}

class DriverHomeInitailState extends DriverHomeState {
  @override
  List<Object?> get props => [];
}

class DriverHomeLoadingState extends DriverHomeState {
  @override
  List<Object?> get props => [];
}

class DriverHomeFetchState extends DriverHomeState {
  final DriverEntity driverEntity;

  DriverHomeFetchState({required this.driverEntity});
  @override
  List<Object?> get props => [driverEntity];
}

class DriverHomeErrorState extends DriverHomeState {
  final String message;

  DriverHomeErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

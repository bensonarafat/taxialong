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

class DriverHomeOnlineError extends DriverHomeState {
  final String message;

  DriverHomeOnlineError({required this.message});

  @override
  List<Object?> get props => [message];
}

class DriverHomeOnlineUpdated extends DriverHomeState {
  final GoOnlineEntity goOnlineEntity;

  DriverHomeOnlineUpdated({required this.goOnlineEntity});

  @override
  List<Object?> get props => [goOnlineEntity];
}

class DriverHomePositionUpdatedState extends DriverHomeState {
  final String latitude;
  final String longitude;
  final List<Marker> markers;

  DriverHomePositionUpdatedState({
    required this.latitude,
    required this.longitude,
    required this.markers,
  });
  @override
  List<Object?> get props => [
        latitude,
        longitude,
        markers,
      ];
}

class RecentLoading extends DriverHomeState {
  @override
  List<Object?> get props => [];
}

class RequestLoading extends DriverHomeState {
  @override
  List<Object?> get props => [];
}

class RecentLoaded extends DriverHomeState {
  final List<TripEntity> tripEntity;

  RecentLoaded({required this.tripEntity});
  @override
  List<Object?> get props => [tripEntity];
}

class RequestLoaded extends DriverHomeState {
  final List<TripEntity> tripEntity;

  RequestLoaded({required this.tripEntity});
  @override
  List<Object?> get props => [tripEntity];
}

class RecentError extends DriverHomeState {
  final String message;

  RecentError({required this.message});

  @override
  List<Object?> get props => [message];
}

class RequestError extends DriverHomeState {
  final String message;

  RequestError({required this.message});

  @override
  List<Object?> get props => [message];
}

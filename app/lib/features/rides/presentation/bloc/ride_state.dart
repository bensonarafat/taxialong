part of 'ride_bloc.dart';

@immutable
abstract class RideState extends Equatable {}

class RideLoadingState extends RideState {
  @override
  List<Object?> get props => [];
}

class RideLoadedState extends RideState {
  final List<RidesEntity> ridesEntity;

  RideLoadedState({required this.ridesEntity});

  @override
  List<Object?> get props => [ridesEntity];
}

class RideErrorState extends RideState {
  final String message;

  RideErrorState({required this.message});
  @override
  List<Object?> get props => [message];
}

class RideLocationDisableState extends RideState {
  @override
  List<Object?> get props => [];
}

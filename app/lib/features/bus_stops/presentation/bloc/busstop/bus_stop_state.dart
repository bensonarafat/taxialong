part of 'bus_stop_bloc.dart';

@immutable
abstract class BusStopState extends Equatable {}

class BusStopLoadingState extends BusStopState {
  @override
  List<Object?> get props => [];
}

class BusStopLoadedState extends BusStopState {
  final List<AxisEntity> busstops;

  BusStopLoadedState({required this.busstops});

  @override
  List<Object?> get props => [busstops];
}

class BusStopErrorState extends BusStopState {
  final String message;

  BusStopErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

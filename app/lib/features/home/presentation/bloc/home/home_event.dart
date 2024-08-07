part of 'home_bloc.dart';

@immutable
abstract class HomeEvent extends Equatable {}

class FetchHomeTerminalsEvent extends HomeEvent {
  FetchHomeTerminalsEvent();
  @override
  List<Object?> get props => [];
}

class UpdateTerminalEvent extends HomeEvent {
  final double latitude;
  final double longitude;

  UpdateTerminalEvent({required this.latitude, required this.longitude});

  @override
  List<Object?> get props => [latitude, longitude];
}

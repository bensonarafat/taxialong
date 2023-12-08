part of 'map_bloc.dart';

@immutable
abstract class MapState extends Equatable {}

class MapInitialState extends MapState {
  @override
  List<Object?> get props => [];
}

class MapError extends MapState {
  @override
  List<Object?> get props => [];
}

class MapLoaded extends MapState {
  @override
  List<Object?> get props => [];
}

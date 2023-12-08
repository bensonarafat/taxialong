part of 'map_bloc.dart';

@immutable
abstract class MapEvent extends Equatable {}

class MapCurrentPositionEvent extends MapEvent {
  @override
  List<Object?> get props => [];
}

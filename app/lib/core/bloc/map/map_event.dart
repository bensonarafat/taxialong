part of 'map_bloc.dart';

@immutable
abstract class MapEvent extends Equatable {}

class MapCurrentPositionEvent extends MapEvent {
  @override
  List<Object?> get props => [];
}

class MapUpdateCurrentPostionEvent extends MapEvent {
  final String latitude;
  final String longitude;

  MapUpdateCurrentPostionEvent(
      {required this.latitude, required this.longitude});
  @override
  List<Object?> get props => [latitude, longitude];
}

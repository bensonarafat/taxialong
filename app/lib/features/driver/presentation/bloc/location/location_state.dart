part of 'location_bloc.dart';

abstract class LocationState extends Equatable {}

class LocationInitState extends LocationState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class LocationLoadingState extends LocationState {
  @override
  List<Object?> get props => [];
}

class LocationPositionUpdatedState extends LocationState {
  final double latitude;
  final double longitude;
  final List<Marker> markers;

  LocationPositionUpdatedState({
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

part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {}

class LocationUpdateLocationEvent extends LocationEvent {
  final double latitude;
  final double longitude;

  LocationUpdateLocationEvent(
      {required this.latitude, required this.longitude});
  @override
  List<Object?> get props => [latitude, longitude];
}

part of 'ride_bloc.dart';

@immutable
abstract class RideEvent extends Equatable {}

class FetchRideEvent extends RideEvent {
  final String pointb;
  final List<dynamic>? rideClass;

  FetchRideEvent({
    required this.pointb,
    required this.rideClass,
  });

  @override
  List<Object?> get props => [
        pointb,
        rideClass,
      ];
}

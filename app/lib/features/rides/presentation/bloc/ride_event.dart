part of 'ride_bloc.dart';

@immutable
abstract class RideEvent extends Equatable {}

class FetchRideEvent extends RideEvent {
  final String pointb;
  final List<dynamic>? rideClass;
  final String? seat;

  FetchRideEvent({
    required this.pointb,
    this.rideClass,
    this.seat,
  });

  @override
  List<Object?> get props => [
        pointb,
        rideClass,
        seat,
      ];
}

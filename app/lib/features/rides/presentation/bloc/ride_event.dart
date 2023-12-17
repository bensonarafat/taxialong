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

class RideBookEvent extends RideEvent {
  final List<dynamic> seats;
  final String amount;
  final String driverId;
  final String pointa;
  final String pointb;
  final String tripClass;
  final String paymentMethod;

  RideBookEvent(
      {required this.seats,
      required this.amount,
      required this.driverId,
      required this.pointa,
      required this.pointb,
      required this.tripClass,
      required this.paymentMethod});
  @override
  List<Object?> get props => [
        seats,
        amount,
        driverId,
        pointa,
        pointb,
        tripClass,
        paymentMethod,
      ];
}

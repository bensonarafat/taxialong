part of 'ride_bloc.dart';

@immutable
abstract class RideEvent extends Equatable {}

class FetchRideEvent extends RideEvent {
  final int pointb;
  final List<dynamic>? rideClass;

  FetchRideEvent({
    required this.pointb,
    this.rideClass,
  });

  @override
  List<Object?> get props => [
        pointb,
        rideClass,
      ];
}

class RideBookEvent extends RideEvent {
  final List<int> seats;
  final Map<String, dynamic> rideClass;
  final int driverId;
  final int pointa;
  final int pointb;
  final String paymentMethod;
  final int carId;

  RideBookEvent({
    required this.seats,
    required this.rideClass,
    required this.driverId,
    required this.pointa,
    required this.pointb,
    required this.paymentMethod,
    required this.carId,
  });
  @override
  List<Object?> get props => [
        seats,
        rideClass,
        driverId,
        pointa,
        pointb,
        paymentMethod,
        carId,
      ];
}

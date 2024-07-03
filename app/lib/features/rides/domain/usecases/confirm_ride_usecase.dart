import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/core/usecases/usecase.dart';
import 'package:taxialong/features/rides/domain/entities/confirm_ride_entity.dart';
import 'package:taxialong/features/rides/domain/repositories/ride_repository.dart';

class ConfirmRideUseCase
    implements UseCase<ConfirmRideEntity, ConfirmRideParams> {
  RideRepository repository;
  ConfirmRideUseCase({required this.repository});
  @override
  Future<Either<Failure, ConfirmRideEntity>> call(
      ConfirmRideParams params) async {
    return await repository.confirmRide(params);
  }
}

class ConfirmRideParams extends Equatable {
  final List<int> seats;
  final Map<String, dynamic> rideClass;
  final int driverId;
  final int pointa;
  final int pointb;
  final String paymentMethod;
  final int carId;

  const ConfirmRideParams({
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

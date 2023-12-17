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
  final String amount;
  final String paymentMethod;
  final String driverId;
  final List<int> seats;
  final String pointa;
  final String pointb;
  final String tripClass;

  const ConfirmRideParams(
      {required this.amount,
      required this.paymentMethod,
      required this.driverId,
      required this.seats,
      required this.pointa,
      required this.pointb,
      required this.tripClass});

  @override
  List<Object?> get props => [
        amount,
        paymentMethod,
        driverId,
        seats,
        pointa,
        pointb,
        tripClass,
      ];
}

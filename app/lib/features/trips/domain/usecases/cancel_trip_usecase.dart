import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/core/usecases/usecase.dart';
import 'package:taxialong/features/trips/domain/entities/cancel_entity.dart';
import 'package:taxialong/features/trips/domain/repositories/trip_repository.dart';

class CancelTripUseCase extends UseCase<CancelEntity, CancelParam> {
  TripRepository repository;
  CancelTripUseCase({required this.repository});
  @override
  Future<Either<Failure, CancelEntity>> call(CancelParam params) async {
    return await repository.cancelTrip(params);
  }
}

class CancelParam extends Equatable {
  final String tripId;
  final String reason;

  const CancelParam({required this.tripId, required this.reason});
  @override
  List<Object?> get props => [reason, tripId];
}

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/features/trips/domain/entities/cancel_entity.dart';
import 'package:taxialong/features/trips/domain/entities/trip_entity.dart';
import 'package:taxialong/features/trips/domain/entities/update_trip_entity.dart';
import 'package:taxialong/features/trips/domain/usecases/cancel_trip_usecase.dart';
import 'package:taxialong/features/trips/domain/usecases/get_trip_usecase.dart';
import 'package:taxialong/features/trips/domain/usecases/update_complete_usecase.dart';
import 'package:taxialong/features/trips/domain/usecases/update_pickup_usecase.dart';

part 'trip_event.dart';
part 'trip_state.dart';

class TripBloc extends Bloc<TripEvent, TripState> {
  final GetTripUseCase getTripUseCase;
  final CancelTripUseCase cancelTripUseCase;
  final UpdatePickUpUseCase updatePickUpUseCase;
  final UpdateCompleteUseCase updateCompleteUseCase;
  TripBloc({
    required this.getTripUseCase,
    required this.cancelTripUseCase,
    required this.updateCompleteUseCase,
    required this.updatePickUpUseCase,
  }) : super(TripInit()) {
    on<TripEvent>((event, emit) async {
      if (event is GetTripEvent) {
        final failureOrTripEvent = await getTripUseCase({});

        emit(
          failureOrTripEvent.fold(
            (failure) => TripErrorState(message: mapFailureToMessage(failure)),
            (tripEntity) => TripLoadedState(tripEntity: tripEntity),
          ),
        );
      } else if (event is CancelTripEvent) {
        emit(TripLoadingState());
        final failureOrTripEvent = await cancelTripUseCase(
            CancelParam(tripId: event.tripId, reason: event.reason));
        emit(
          failureOrTripEvent.fold(
            (failure) => TripErrorState(message: mapFailureToMessage(failure)),
            (cancelEntity) => TripCancelState(cancelEntity: cancelEntity),
          ),
        );
      } else if (event is UpdatePickUpEvent) {
        final finalureOrUpdate = await updatePickUpUseCase({});
        emit(
          finalureOrUpdate.fold(
            (failure) => TripErrorState(message: mapFailureToMessage(failure)),
            (updateTripEntity) =>
                UpdatePickUpState(updateTripEntity: updateTripEntity),
          ),
        );
      } else if (event is UpdateCompletedEvent) {
        final finalureOrUpdate = await updateCompleteUseCase({});
        emit(
          finalureOrUpdate.fold(
            (failure) => TripErrorState(message: mapFailureToMessage(failure)),
            (updateTripEntity) =>
                UpdateCompleteState(updateTripEntity: updateTripEntity),
          ),
        );
      }
    });
  }
}

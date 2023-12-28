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
    on<UpdateCompletedEvent>(
        (event, emit) => updateCompletedEvent(event, emit));
    on<UpdatePickUpEvent>((event, emit) => updatePickUpEvent(event, emit));
    on<CancelTripEvent>((event, emit) => cancelTripEvent(event, emit));
    on<GetTripEvent>((event, emit) => getTripEvent(event, emit));
  }

  getTripEvent(event, emit) async {
    final failureOrTripEvent = await getTripUseCase({});

    emit(
      failureOrTripEvent.fold(
        (failure) => TripErrorState(message: mapFailureToMessage(failure)),
        (tripEntity) => TripLoadedState(tripEntity: tripEntity),
      ),
    );
  }

  cancelTripEvent(event, emit) async {
    emit(TripLoadingState());
    final failureOrTripEvent = await cancelTripUseCase(
        CancelParam(tripId: event.tripId, reason: event.reason));
    emit(
      failureOrTripEvent.fold(
        (failure) => TripErrorState(message: mapFailureToMessage(failure)),
        (cancelEntity) => TripCancelState(cancelEntity: cancelEntity),
      ),
    );
  }

  updatePickUpEvent(event, emit) async {
    final finalureOrUpdate = await updatePickUpUseCase({});
    emit(
      finalureOrUpdate.fold(
        (failure) => TripErrorState(message: mapFailureToMessage(failure)),
        (updateTripEntity) =>
            UpdatePickUpState(updateTripEntity: updateTripEntity),
      ),
    );
  }

  updateCompletedEvent(event, emit) async {
    final finalureOrUpdate = await updateCompleteUseCase({});
    emit(
      finalureOrUpdate.fold(
        (failure) => TripErrorState(message: mapFailureToMessage(failure)),
        (updateTripEntity) =>
            UpdateCompleteState(updateTripEntity: updateTripEntity),
      ),
    );
  }
}

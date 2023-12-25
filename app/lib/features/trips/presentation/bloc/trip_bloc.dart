import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/features/trips/domain/entities/trip_entity.dart';
import 'package:taxialong/features/trips/domain/usecases/get_trip_usecase.dart';

part 'trip_event.dart';
part 'trip_state.dart';

class TripBloc extends Bloc<TripEvent, TripState> {
  final GetTripUseCase getTripUseCase;
  TripBloc({
    required this.getTripUseCase,
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
      }
    });
  }
}

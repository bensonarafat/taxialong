import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/features/trips/domain/entities/cancel_entity.dart';
import 'package:taxialong/features/trips/domain/usecases/cancel_trip_usecase.dart';

part 'cancel_event.dart';
part 'cancel_state.dart';

class CancelBloc extends Bloc<CancelEvent, CancelState> {
  final CancelTripUseCase cancelTripUseCase;
  CancelBloc({
    required this.cancelTripUseCase,
  }) : super(CancelInitState()) {
    on<CancelTripEvent>((event, emit) => cancelTripEvent(event, emit));
  }

  cancelTripEvent(event, emit) async {
    emit(CancelLoadingState());
    final failureOrTripEvent = await cancelTripUseCase(
        CancelParam(tripId: event.tripId, reason: event.reason));
    emit(
      failureOrTripEvent.fold(
        (failure) => CancelErrorState(message: mapFailureToMessage(failure)),
        (cancelEntity) => TripCancelState(cancelEntity: cancelEntity),
      ),
    );
  }
}

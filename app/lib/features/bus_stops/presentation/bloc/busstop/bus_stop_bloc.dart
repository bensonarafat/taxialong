import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/features/bus_stops/domain/entities/axis_entity.dart';
import 'package:taxialong/features/bus_stops/domain/usecases/get_bus_stop_usecase.dart';

part 'bus_stop_event.dart';
part 'bus_stop_state.dart';

class BusStopBloc extends Bloc<BusStopEvent, BusStopState> {
  final GetBusStopUseCase busStopUseCase;
  BusStopBloc({
    required this.busStopUseCase,
  }) : super(BusStopLoadingState()) {
    on<BusStopEvent>((event, emit) async {
      if (event is BusStopFetchEvent) {
        emit(BusStopLoadingState());
        final failureOrFetchAxisEvent = await busStopUseCase(
          AxisParams(
            pointa: event.pointa,
            pointb: event.pointb,
          ),
        );
        emit(failureOrFetchAxisEvent.fold(
            (failure) =>
                BusStopErrorState(message: _mapFailureToMessage(failure)),
            (busstops) => BusStopLoadedState(busstops: busstops)));
      }
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'There was a server error!';
      case CacheFailure:
        return 'Cache Failure';
      case NetworkFailure:
        return 'Network error, check your internet connection';
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/features/home/domain/entities/axis_entity.dart';
import 'package:taxialong/features/home/domain/usecases/get_axis.dart';

part 'home_state.dart';
part 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetAxisUseCase axisUseCase;

  HomeBloc({required this.axisUseCase}) : super(HomeLoadingState()) {
    on<HomeEvent>((event, emit) async {
      if (event is FetchHomeTerminals) {
        emit(HomeLoadingState());

        final failureOrFetchTerminalsEvent = await axisUseCase(
          PositionParams(latitude: event.latitude, longitude: event.longitude),
        );

        emit(failureOrFetchTerminalsEvent.fold(
            (failure) => HomeErrorState(message: _mapFailureToMessage(failure)),
            (axisEntity) => HomeLoadedState(axisEntity: axisEntity)));
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

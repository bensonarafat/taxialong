import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/features/home/domain/entities/axis_entity.dart';
import 'package:taxialong/features/home/domain/usecases/get_axis.dart';
import 'package:taxialong/features/home/domain/usecases/get_cache.dart';

part 'home_state.dart';
part 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetAxisUseCase axisUseCase;
  final GetAxisCachedUseCase axisCachedUseCase;

  HomeBloc({
    required this.axisUseCase,
    required this.axisCachedUseCase,
  }) : super(HomeLoadingState()) {
    on<HomeEvent>((event, emit) async {
      if (event is UpdateTerminalEvent) {
        final failureOrFetchTerminalsEvent = await axisUseCase(
          PositionParams(
            latitude: event.latitude,
            longitude: event.longitude,
          ),
        );

        emit(failureOrFetchTerminalsEvent.fold(
            (failure) => HomeErrorState(message: mapFailureToMessage(failure)),
            (axisEntity) => HomeLoadedState(axisEntity: axisEntity)));
      }
    });
  }
}

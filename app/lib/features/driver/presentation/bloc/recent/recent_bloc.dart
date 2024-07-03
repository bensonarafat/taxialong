import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/features/driver/domain/usecases/get_recent_usecase.dart';
import 'package:taxialong/features/trips/domain/entities/trip_entity.dart';

part 'recent_event.dart';
part 'recent_state.dart';

class RecentBloc extends Bloc<RecentEvent, RecentState> {
  GetRecentUseCase getRecentUseCase;
  RecentBloc({required this.getRecentUseCase}) : super(RecentInitState()) {
    on<DriverHomeFetchRecents>(
        (event, emit) => driverHomeFetchRecents(event, emit));
  }

  driverHomeFetchRecents(event, emit) async {
    if (event.loading) {
      emit(RecentLoading());
    }

    var failureOrRequestData = await getRecentUseCase({});

    emit(failureOrRequestData.fold(
        (failure) => RecentError(message: mapFailureToMessage(failure)),
        (tripEntity) => RecentLoaded(tripEntity: tripEntity)));
  }
}

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/features/driver/domain/usecases/get_request_usecase.dart';
import 'package:taxialong/features/trips/domain/entities/trip_entity.dart';

part 'request_event.dart';
part 'request_state.dart';

class RequestBloc extends Bloc<RequestEvent, RequestState> {
  GetRequestUseCase getRequestUseCase;
  RequestBloc({
    required this.getRequestUseCase,
  }) : super(RequestInitState()) {
    on<DriverHomeFetchRequests>(
        (event, emit) => driverHomeFetchRequests(event, emit));
  }

  driverHomeFetchRequests(event, emit) async {
    if (event.loading) {
      emit(RequestLoading());
    }

    var failureOrRequestData = await getRequestUseCase({});

    emit(failureOrRequestData.fold(
        (failure) => RequestError(message: mapFailureToMessage(failure)),
        (tripEntity) => RequestLoaded(tripEntity: tripEntity)));
  }
}

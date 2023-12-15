import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/features/rides/domain/entities/rides_entity.dart';
import 'package:taxialong/features/rides/domain/usecases/get_rides_usecase.dart';

part 'ride_event.dart';
part 'ride_state.dart';

class RideBloc extends Bloc<RideEvent, RideState> {
  final GetRidesUseCase getRidesUseCase;
  RideBloc({required this.getRidesUseCase}) : super(RideLoadingState()) {
    on<RideEvent>((event, emit) async {
      if (event is FetchRideEvent) {
        emit(RideLoadingState());
        if (await serviceEnabled()) {
          Position position = await Geolocator.getCurrentPosition();
          final failureOrRideEvent = await getRidesUseCase(
            RideParams(
              latitude: position.latitude.toString(),
              longitude: position.longitude.toString(),
              pointb: event.pointb,
              rideClass: event.rideClass,
              seat: event.seat,
            ),
          );

          emit(failureOrRideEvent.fold(
              (failure) =>
                  RideErrorState(message: mapFailureToMessage(failure)),
              (ridesEntity) => RideLoadedState(ridesEntity: ridesEntity)));
        } else {
          emit(RideLocationDisableState());
        }
      }
    });
  }
}

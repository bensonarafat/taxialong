import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/features/rides/domain/entities/confirm_ride_entity.dart';
import 'package:taxialong/features/rides/domain/entities/rides_entity.dart';
import 'package:taxialong/features/rides/domain/usecases/confirm_ride_usecase.dart';
import 'package:taxialong/features/rides/domain/usecases/get_rides_usecase.dart';

part 'ride_event.dart';
part 'ride_state.dart';

class RideBloc extends Bloc<RideEvent, RideState> {
  final GetRidesUseCase getRidesUseCase;
  final ConfirmRideUseCase confirmRideUseCase;
  RideBloc({
    required this.getRidesUseCase,
    required this.confirmRideUseCase,
  }) : super(RideLoadingState()) {
    on<RideEvent>((event, emit) async {
      if (event is FetchRideEvent) {
        emit(RideLoadingState());
        if (await serviceEnabled()) {
          Position position = await Geolocator.getCurrentPosition();
          final failureOrRideEvent = await getRidesUseCase(
            RideParams(
              latitude: position.latitude,
              longitude: position.longitude,
              pointb: event.pointb,
              rideClass: event.rideClass,
            ),
          );

          emit(failureOrRideEvent.fold(
              (failure) =>
                  RideErrorState(message: mapFailureToMessage(failure)),
              (ridesEntity) => RideLoadedState(ridesEntity: ridesEntity)));
        } else {
          emit(RideLocationDisableState());
        }
      } else if (event is RideBookEvent) {
        emit(RideBookLoadingState());
        final failureOrRideEvent = await confirmRideUseCase(
          ConfirmRideParams(
            seats: event.seats,
            rideClass: event.rideClass,
            driverId: event.driverId,
            pointa: event.pointa,
            pointb: event.pointb,
            paymentMethod: event.paymentMethod,
            carId: event.carId,
          ),
        );

        emit(failureOrRideEvent.fold(
            (failure) => RideErrorState(message: mapFailureToMessage(failure)),
            (confirmRideEntity) =>
                RideBookLoadedState(confirmRideEntity: confirmRideEntity)));
      }
    });
  }
}

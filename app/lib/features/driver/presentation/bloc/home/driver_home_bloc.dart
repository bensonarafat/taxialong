import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/features/driver/domain/entities/driver_entity.dart';
import 'package:taxialong/features/driver/domain/entities/go_online_entity.dart';
import 'package:taxialong/features/driver/domain/usecases/get_driver_data_usecase.dart';
import 'package:taxialong/features/driver/domain/usecases/go_online_usecase.dart';

part 'driver_home_state.dart';
part 'driver_home_event.dart';

class DriverHomeBloc extends Bloc<DriverHomeEvent, DriverHomeState> {
  GoOnlineUseCase goOnlineUseCase;
  GetDriverDataUseCase getDriverDataUseCase;
  late StreamSubscription<Position> positionStream;
  DriverHomeBloc({
    required this.getDriverDataUseCase,
    required this.goOnlineUseCase,
  }) : super(DriverHomeInitailState()) {
    on<DriverHomeEvent>((event, emit) async {
      mapStartLocationUpdateToState();

      if (event is DriverHomeGoOnlineEvent) {
        var failureOrOnline = await goOnlineUseCase({});

        emit(failureOrOnline.fold(
            (failure) =>
                DriverHomeOnlineError(message: mapFailureToMessage(failure)),
            (goOnlineEntity) =>
                DriverHomeOnlineUpdated(goOnlineEntity: goOnlineEntity)));
      } else if (event is DriverHomeFetchEvent) {
        emit(DriverHomeLoadingState());

        var failureOrDriverData = await getDriverDataUseCase({});

        emit(failureOrDriverData.fold(
            (failure) =>
                DriverHomeErrorState(message: mapFailureToMessage(failure)),
            (driverEntity) =>
                DriverHomeFetchState(driverEntity: driverEntity)));
      }
    });
  }

  void mapStartLocationUpdateToState() async {
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position? position) {
      if (position != null) {
        if (!_isDisposed) {
          // add(
          //   UpdateTerminalEvent(
          //       latitude: position.latitude.toString(),
          //       longitude: position.longitude.toString()),
          // );
        }
      }
    });
  }

  bool _isDisposed = false;
  @override
  Future<void> close() {
    positionStream.cancel();
    _isDisposed = true;
    return super.close();
  }
}

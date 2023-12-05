import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:taxialong/features/driver/domain/usecases/switch_role_usecase.dart';

part 'driver_home_state.dart';
part 'driver_home_event.dart';

class DriverHomeBloc extends Bloc<DriverHomeEvent, DriverHomeState> {
  SwitchRoleUseCase switchRoleUseCase;
  late StreamSubscription<Position> positionStream;
  DriverHomeBloc({
    required this.switchRoleUseCase,
  }) : super(DriverHomeInitailState()) {
    on<DriverHomeEvent>((event, emit) {
      mapStartLocationUpdateToState();
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

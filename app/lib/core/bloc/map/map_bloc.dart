import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:taxialong/core/utils/helpers.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  late StreamSubscription<Position> positionStream;
  MapBloc() : super(MapInitialState()) {
    on<MapEvent>((event, emit) async {
      if (await serviceEnabled()) {
        mapStartLocationUpdateToState();
      }
      if (event is MapCurrentPositionEvent) {
        String latitude = '9.0765';
        String longitude = '7.3986';
        if (await serviceEnabled()) {
          Position position = await Geolocator.getCurrentPosition();
          latitude = position.latitude.toString();
          longitude = position.longitude.toString();
        }
        emit(
          MapCurrentPositionState(
            latitude: latitude,
            longitude: longitude,
          ),
        );
      } else if (event is MapUpdateCurrentPostionEvent) {
        emit(
          MapCurrentPositionState(
            latitude: event.latitude,
            longitude: event.longitude,
          ),
        );
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
          add(
            MapUpdateCurrentPostionEvent(
                latitude: position.latitude.toString(),
                longitude: position.longitude.toString()),
          );
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

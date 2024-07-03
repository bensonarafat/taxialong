import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxialong/core/constants/constants.dart';
import 'package:taxialong/core/utils/helpers.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  late StreamSubscription<Position> positionStream;

  late BitmapDescriptor customIcon;

  Set<Marker> markers = {};
  MapBloc() : super(MapInitialState()) {
    on<MapEvent>((event, emit) async {
      if (await serviceEnabled()) {
        mapStartLocationUpdateToState();
      }
    });
    on<MapCurrentPositionEvent>(
        (event, emit) => mapCurrentPositionEvent(event, emit));
    on<MapUpdateCurrentPostionEvent>(
        (event, emit) => mapUpdateCurrentPostionEvent(event, emit));
    on<UpdatePickUpMapEvent>((event, emit) => emit(TripOnGoingState()));
    on<DriverUpdateLocationEvent>(
        (event, emit) => driverUpdateLocationEvent(event, emit));
  }

  driverUpdateLocationEvent(DriverUpdateLocationEvent event, emit) async {
    customIcon = await createMarkerIcon();
    markers.add(
      Marker(
        icon: customIcon,
        markerId: const MarkerId('driver'),
        position: LatLng(event.latitude, event.longitude),
      ),
    );
    emit(
      DriverLocationUpdatedState(
        latitude: event.latitude,
        longitude: event.longitude,
        markers: markers,
      ),
    );
  }

  mapUpdateCurrentPostionEvent(event, emit) async {
    emit(
      MapCurrentPositionState(
        latitude: event.latitude,
        longitude: event.longitude,
      ),
    );
  }

  mapCurrentPositionEvent(MapCurrentPositionEvent event, emit) async {
    double latitude = defaultLat;
    double longitude = defaultLng;

    if (await serviceEnabled()) {
      Position position = await Geolocator.getCurrentPosition();
      latitude = position.latitude;
      longitude = position.longitude;
    }
    emit(
      MapCurrentPositionState(
        latitude: latitude,
        longitude: longitude,
      ),
    );
  }

  void mapStartLocationUpdateToState() async {
    const LocationSettings locationSettings =
        LocationSettings(distanceFilter: 5);
    positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position? position) {
      positionStream.cancel();
      if (position != null) {
        if (!_isDisposed) {
          add(
            MapUpdateCurrentPostionEvent(
              latitude: position.latitude,
              longitude: position.longitude,
            ),
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

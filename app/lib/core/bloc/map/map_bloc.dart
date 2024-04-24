import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxialong/core/utils/helpers.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  late StreamSubscription<Position> positionStream;

  late BitmapDescriptor customIcon;

  List<Marker> markers = <Marker>[];
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

  driverUpdateLocationEvent(event, emit) async {
    customIcon = await createMarkerIcon();
    markers.add(
      Marker(
        icon: customIcon,
        markerId: const MarkerId('driver'),
        position:
            LatLng(double.parse(event.latitude), double.parse(event.longitude)),
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

  mapCurrentPositionEvent(event, emit) async {
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
              longitude: position.longitude.toString(),
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

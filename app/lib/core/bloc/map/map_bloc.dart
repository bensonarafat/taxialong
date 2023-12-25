import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:taxialong/core/constants/constants.dart';
import 'package:taxialong/core/utils/helpers.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  late StreamSubscription<Position> positionStream;
  final PusherChannelsFlutter pusher;

  MapBloc({required this.pusher}) : super(MapInitialState()) {
    on<MapEvent>((event, emit) async {
      try {
        await pusher.init(
          apiKey: pusherAPIKey,
          cluster: pusherCluster,
          onEvent: (PusherEvent e) {
            final data = jsonDecode(e.data);
            emit(
              DriverLocationUpdatedState(
                  latitude: data['latitude'], longitude: data['longitude']),
            );
          },
        );
      } catch (e) {
        // print("ERROR: $e");
      }

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
      } else if (event is GetDriverLocationEvent) {
        await pusher.connect();
        await pusher.subscribe(channelName: "driver-location${event.driverId}");
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

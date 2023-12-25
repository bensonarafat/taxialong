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
      initPusher();

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
      } else if (event is SubscribeToDriverChannel) {
        await pusher.subscribe(
            channelName: "driver-locations${event.driverId}");
      } else if (event is PusherUpdateLocationEvent) {
        // print("EVENT ==> $event");
        emit(
          DriverLocationUpdatedState(
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
              longitude: position.longitude.toString(),
            ),
          );
        }
      }
    });
  }

  Future<void> initPusher() async {
    try {
      await pusher.init(
        apiKey: pusherAPIKey,
        cluster: pusherCluster,
        onEvent: (PusherEvent e) {
          final data = jsonDecode(e.data);

          // print("DATA ==> $data");
          add(
            PusherUpdateLocationEvent(
              latitude: data['latitude'],
              longitude: data['longitude'],
            ),
          );
        },
      );
      await pusher.connect(); // Connect immediately
    } catch (e) {
      // print("ERROR >>>>> : $e");
    }
  }

  bool _isDisposed = false;
  @override
  Future<void> close() {
    positionStream.cancel();
    pusher.disconnect();
    _isDisposed = true;
    return super.close();
  }
}

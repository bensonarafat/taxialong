import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:taxialong/core/services/websocket/pusher_client_websocket.dart';
import 'package:taxialong/core/services/websocket/pusher_websocket.dart';

part 'pusher_state.dart';
part 'pusher_event.dart';

class PusherBloc extends Bloc<PusherEvent, PusherState> {
  late PusherWebSocket webSocket;

  PusherBloc() : super(PusherInitState()) {
    on<SubscribeToDriverChannel>(
        (event, emit) => subscribeToDriverChannel(event, emit));
    on<SubscribeToTripChannel>(
        (event, emit) => subscribeToTripChannel(event, emit));
    on<PusherTripUpdateEvent>((event, emit) => emit(PusherTripUpdateState()));
    on<PusherUpdateLocationEvent>(
      (event, emit) {
        emit(
          PusherUpdateLocationState(
            latitude: event.latitude,
            longitude: event.longitude,
          ),
        );
      },
    );
  }

  subscribeToDriverChannel(event, emit) async {
    webSocket = PusherClientWebSocket(
        eventHandler: (e) {
          String locationString = e.data;
          Map<String, dynamic> location = jsonDecode(locationString);

          add(PusherUpdateLocationEvent(
            latitude: location['latitude'].toString(),
            longitude: location['longitude'].toString(),
          ));
        },
        channelName: "driver-locations${event.driverId}");

    webSocket.close();
  }

  subscribeToTripChannel(event, emit) async {
    webSocket = PusherClientWebSocket(
        eventHandler: (data) {
          add(PusherTripUpdateEvent());
        },
        channelName: "update-trip${event.driverId}");
    webSocket.close();
  }

  @override
  Future<void> close() {
    webSocket.close();
    return super.close();
  }
}

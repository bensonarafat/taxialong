import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:taxialong/core/constants/constants.dart';
import 'package:taxialong/core/services/websocket/pusher_websocket.dart';

class PusherClientWebSocket implements PusherWebSocket {
  PusherClientWebSocket(
      {required this.channelName, required this.eventHandler}) {
    connect();
  }
  @override
  late PusherChannelsFlutter pusher;

  @override
  void connect() async {
    pusher = PusherChannelsFlutter.getInstance();
    await pusher.init(
      apiKey: pusherAPIKey,
      cluster: pusherCluster,
      onConnectionStateChange: onConnectionStateChange,
      onError: onError,
      onSubscriptionSucceeded: onSubscriptionSucceeded,
      onSubscriptionError: onSubscriptionError,
      onEvent: (PusherEvent e) {
        eventHandler(e);
      },
    );
    await pusher.subscribe(channelName: channelName);
    await pusher.connect();
  }

  @override
  void close() async {
    await pusher.disconnect();
  }

  @override
  void send() {}

  @override
  dynamic data;

  @override
  late Function(dynamic data) eventHandler;

  @override
  String channelName;

  void onSubscriptionError(String message, dynamic e) {}

  void onSubscriptionSucceeded(String channelName, dynamic data) {}

  void onError(String message, int? code, dynamic e) {}

  void onConnectionStateChange(dynamic currentState, dynamic previousState) {}
}

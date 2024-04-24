abstract class PusherWebSocket {
  late dynamic _pusher;

  late Function(dynamic data) eventHandler;

  dynamic data;

  late String channelName;

  void connect();
  void close();
  void send();

  dynamic get pusher => _pusher;
}

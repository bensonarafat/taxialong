part of 'bus_stop_bloc.dart';

@immutable
abstract class BusStopEvent extends Equatable {}

class BusStopFetchEvent extends BusStopEvent {
  final int pointa;
  final int pointb;

  BusStopFetchEvent({required this.pointa, required this.pointb});
  @override
  List<Object?> get props => [pointa, pointb];
}

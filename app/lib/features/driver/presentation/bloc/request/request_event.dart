part of 'request_bloc.dart';

abstract class RequestEvent extends Equatable {}

class DriverHomeFetchRequests extends RequestEvent {
  final bool loading;

  DriverHomeFetchRequests({required this.loading});
  @override
  List<Object?> get props => [loading];
}

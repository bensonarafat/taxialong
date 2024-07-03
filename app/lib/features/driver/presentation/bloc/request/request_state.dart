part of 'request_bloc.dart';

abstract class RequestState extends Equatable {}

class RequestInitState extends RequestState {
  @override
  List<Object?> get props => [];
}

class RequestLoading extends RequestState {
  @override
  List<Object?> get props => [];
}

class RequestError extends RequestState {
  final String message;

  RequestError({required this.message});

  @override
  List<Object?> get props => [message];
}

class RequestLoaded extends RequestState {
  final List<TripEntity> tripEntity;

  RequestLoaded({required this.tripEntity});
  @override
  List<Object?> get props => [tripEntity];
}

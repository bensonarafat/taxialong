part of 'cancel_bloc.dart';

abstract class CancelState extends Equatable {}

class CancelInitState extends CancelState {
  @override
  List<Object?> get props => [];
}

class TripCancelState extends CancelState {
  final CancelEntity cancelEntity;
  TripCancelState({required this.cancelEntity});
  @override
  List<Object?> get props => [cancelEntity];
}

class CancelLoadingState extends CancelState {
  @override
  List<Object?> get props => [];
}

class CancelErrorState extends CancelState {
  final String message;

  CancelErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

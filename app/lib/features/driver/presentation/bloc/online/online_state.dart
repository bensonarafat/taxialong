part of 'online_bloc.dart';

abstract class OnlineState extends Equatable {}

class OnlineInit extends OnlineState {
  @override
  List<Object?> get props => [];
}

class OnlineError extends OnlineState {
  final String message;

  OnlineError({required this.message});

  @override
  List<Object?> get props => [message];
}

class OnlineUpdated extends OnlineState {
  final GoOnlineEntity goOnlineEntity;

  OnlineUpdated({required this.goOnlineEntity});

  @override
  List<Object?> get props => [goOnlineEntity];
}

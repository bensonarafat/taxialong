part of 'recent_bloc.dart';

abstract class RecentState extends Equatable {}

class RecentInitState extends RecentState {
  @override
  List<Object?> get props => [];
}

class RecentLoading extends RecentState {
  @override
  List<Object?> get props => [];
}

class RecentError extends RecentState {
  final String message;

  RecentError({required this.message});

  @override
  List<Object?> get props => [message];
}

class RecentLoaded extends RecentState {
  final List<TripEntity> tripEntity;

  RecentLoaded({required this.tripEntity});
  @override
  List<Object?> get props => [tripEntity];
}

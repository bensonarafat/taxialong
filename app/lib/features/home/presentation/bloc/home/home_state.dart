part of 'home_bloc.dart';

@immutable
abstract class HomeState extends Equatable {}

class HomeLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeLoadCacheState extends HomeState {
  final List<AxisEntity> axisEntity;

  HomeLoadCacheState({required this.axisEntity});
  @override
  List<Object?> get props => [axisEntity];
}

class HomeLoadedState extends HomeState {
  final List<AxisEntity> axisEntity;

  HomeLoadedState({required this.axisEntity});
  @override
  List<Object?> get props => [axisEntity];
}

class HomeErrorState extends HomeState {
  final String message;

  HomeErrorState({required this.message});
  @override
  List<Object?> get props => [message];
}

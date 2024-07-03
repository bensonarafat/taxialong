part of 'car_bloc.dart';

@immutable
abstract class CarState extends Equatable {}

class InitCarState extends CarState {
  @override
  List<Object?> get props => [];
}

class LoadingCarState extends CarState {
  @override
  List<Object?> get props => [];
}

class ErrorCarState extends CarState {
  final String message;

  ErrorCarState({required this.message});
  @override
  List<Object?> get props => [message];
}

class CreatedCarState extends CarState {
  final CreateCarEntity carEntity;

  CreatedCarState({required this.carEntity});
  @override
  List<Object?> get props => [carEntity];
}

class FetchCarsState extends CarState {
  final CarsEntity carsEntity;

  FetchCarsState({required this.carsEntity});

  @override
  List<Object?> get props => [carsEntity];
}

class FetchCarState extends CarState {
  final CarEntity carEntity;

  FetchCarState({required this.carEntity});

  @override
  List<Object?> get props => [carEntity];
}

class LoadingDefaultCarState extends CarState {
  @override
  List<Object?> get props => [];
}

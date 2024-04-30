part of 'car_bloc.dart';

@immutable
abstract class CarEvent extends Equatable {}

class CreateCarEvent extends CarEvent {
  final String model;
  final String plateNumber;
  final String color;
  final String seats;

  CreateCarEvent(
      {required this.model,
      required this.plateNumber,
      required this.color,
      required this.seats});
  @override
  List<Object?> get props => [
        model,
        plateNumber,
        color,
        seats,
      ];
}

part of 'car_bloc.dart';

@immutable
abstract class CarEvent extends Equatable {}

class CreateCarEvent extends CarEvent {
  final String model;
  final String plateNumber;
  final String color;
  final int seatId;
  final List<dynamic> classes;

  CreateCarEvent({
    required this.model,
    required this.plateNumber,
    required this.color,
    required this.seatId,
    required this.classes,
  });
  @override
  List<Object?> get props => [
        model,
        plateNumber,
        color,
        seatId,
        classes,
      ];
}

class FetchVehiclesEvent extends CarEvent {
  @override
  List<Object?> get props => [];
}

class FetchVehicleEvent extends CarEvent {
  final int id;

  FetchVehicleEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class DeleteVehicleEvent extends CarEvent {
  final int id;

  DeleteVehicleEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class EditCarEvent extends CarEvent {
  final int id;
  final String model;
  final String plateNumber;
  final String color;
  final int seatId;
  final List<dynamic> classes;
  EditCarEvent({
    required this.id,
    required this.color,
    required this.model,
    required this.plateNumber,
    required this.seatId,
    required this.classes,
  });

  @override
  List<Object?> get props => [id, color, model, plateNumber, seatId, classes];
}

class UpdateDefaultCarEvent extends CarEvent {
  final int id;

  UpdateDefaultCarEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

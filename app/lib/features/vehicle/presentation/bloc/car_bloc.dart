import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/features/vehicle/domain/entities/car_entity.dart';
import 'package:taxialong/features/vehicle/domain/entities/cars_entity.dart';
import 'package:taxialong/features/vehicle/domain/entities/create_car_entity.dart';
import 'package:taxialong/features/vehicle/domain/usecases/create_car_usecase.dart';
import 'package:taxialong/features/vehicle/domain/usecases/delete_car_usecase.dart';
import 'package:taxialong/features/vehicle/domain/usecases/edit_car_usecase.dart';
import 'package:taxialong/features/vehicle/domain/usecases/fetch_vehicle_usecase.dart';
import 'package:taxialong/features/vehicle/domain/usecases/fetch_vehicles_usecase.dart';
import 'package:taxialong/features/vehicle/domain/usecases/update_default_usecase.dart';

part 'car_state.dart';
part 'car_event.dart';

class CarBloc extends Bloc<CarEvent, CarState> {
  final CreateCarUsecase createCarUsecase;
  final FetchVehiclesUseCase fetchVehiclesUseCase;
  final DeleteCarUseCase deleteCarUseCase;
  final EditCarUseCase editCarUseCase;
  final FetchVehicleUseCase fetchVehicleUseCase;
  final UpdateDefaultCarUseCase updateDefaultCarUseCase;
  CarBloc({
    required this.createCarUsecase,
    required this.fetchVehiclesUseCase,
    required this.deleteCarUseCase,
    required this.editCarUseCase,
    required this.fetchVehicleUseCase,
    required this.updateDefaultCarUseCase,
  }) : super(InitCarState()) {
    on<CreateCarEvent>((event, emit) => createCar(event, emit));
    on<FetchVehiclesEvent>((event, emit) => fetchVehiclesEvent(event, emit));

    on<FetchVehicleEvent>((event, emit) => fetchVehicleEvent(event, emit));
    on<DeleteVehicleEvent>((event, emit) => deleteVehicleEvent(event, emit));
    on<EditCarEvent>((event, emit) => editCarEvent(event, emit));
    on<UpdateDefaultCarEvent>(
        (event, emit) => updateDefaultCarEvent(event, emit));
  }

  updateDefaultCarEvent(UpdateDefaultCarEvent event, emit) async {
    emit(LoadingDefaultCarState());
    final failureOrFetchEvent = await updateDefaultCarUseCase(CarParam(
      id: event.id,
    ));
    emit(
      failureOrFetchEvent.fold(
        (failure) => ErrorCarState(message: mapFailureToMessage(failure)),
        (carEntity) => CreatedCarState(carEntity: carEntity),
      ),
    );
  }

  editCarEvent(EditCarEvent event, emit) async {
    emit(LoadingCarState());
    final failureOrFetchEvent = await editCarUseCase(EditCarParams(
      id: event.id,
      model: event.model,
      plateNumber: event.plateNumber,
      color: event.color,
      seatId: event.seatId,
      classes: event.classes,
    ));
    emit(
      failureOrFetchEvent.fold(
        (failure) => ErrorCarState(message: mapFailureToMessage(failure)),
        (carEntity) => CreatedCarState(carEntity: carEntity),
      ),
    );
  }

  deleteVehicleEvent(DeleteVehicleEvent event, emit) async {
    emit(LoadingCarState());
    final failureOrFetchEvent = await deleteCarUseCase(CarParam(id: event.id));
    emit(
      failureOrFetchEvent.fold(
        (failure) => ErrorCarState(message: mapFailureToMessage(failure)),
        (carEntity) => CreatedCarState(carEntity: carEntity),
      ),
    );
  }

  fetchVehicleEvent(FetchVehicleEvent event, emit) async {
    emit(LoadingCarState());
    final failureOrFetchEvent =
        await fetchVehicleUseCase(CarParam(id: event.id));
    emit(
      failureOrFetchEvent.fold(
        (failure) => ErrorCarState(message: mapFailureToMessage(failure)),
        (carEntity) => FetchCarState(carEntity: carEntity),
      ),
    );
  }

  fetchVehiclesEvent(FetchVehiclesEvent event, emit) async {
    emit(LoadingCarState());
    final failureOrFetchEvent = await fetchVehiclesUseCase({});
    emit(
      failureOrFetchEvent.fold(
        (failure) => ErrorCarState(message: mapFailureToMessage(failure)),
        (carsEntity) => FetchCarsState(carsEntity: carsEntity),
      ),
    );
  }

  createCar(CreateCarEvent event, emit) async {
    emit(LoadingCarState());
    final failureOrTripEvent = await createCarUsecase(
      CarParams(
        model: event.model,
        plateNumber: event.plateNumber,
        color: event.color,
        seatId: event.seatId,
        classes: event.classes,
      ),
    );
    emit(
      failureOrTripEvent.fold(
        (failure) => ErrorCarState(message: mapFailureToMessage(failure)),
        (carEntity) => CreatedCarState(carEntity: carEntity),
      ),
    );
  }
}

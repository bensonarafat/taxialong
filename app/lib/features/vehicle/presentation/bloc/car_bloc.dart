import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/features/vehicle/domain/entities/create_car_entity.dart';
import 'package:taxialong/features/vehicle/domain/usecases/create_car_usecase.dart';

part 'car_state.dart';
part 'car_event.dart';

class CarBloc extends Bloc<CarEvent, CarState> {
  final CreateCarUsecase createCarUsecase;
  CarBloc({required this.createCarUsecase}) : super(InitCarState()) {
    on<CreateCarEvent>((event, emit) => createCar(event, emit));
  }

  createCar(CreateCarEvent event, emit) async {
    emit(LoadingCarState());
    final failureOrTripEvent = await createCarUsecase(
      CarParams(
        model: event.model,
        plateNumber: event.plateNumber,
        color: event.color,
        seats: event.seats,
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

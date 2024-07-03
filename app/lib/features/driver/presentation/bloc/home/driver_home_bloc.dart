import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/features/driver/domain/entities/driver_entity.dart';
import 'package:taxialong/features/driver/domain/usecases/get_driver_data_usecase.dart';

part 'driver_home_state.dart';
part 'driver_home_event.dart';

class DriverHomeBloc extends Bloc<DriverHomeEvent, DriverHomeState> {
  GetDriverDataUseCase getDriverDataUseCase;
  DriverHomeBloc({
    required this.getDriverDataUseCase,
  }) : super(DriverHomeInitailState()) {
    on<DriverHomeFetchEvent>(
        (event, emit) => driverHomeFetchEvent(event, emit));
  }

  driverHomeFetchEvent(event, emit) async {
    emit(DriverHomeLoadingState());

    var failureOrDriverData = await getDriverDataUseCase({});

    emit(failureOrDriverData.fold(
        (failure) =>
            DriverHomeErrorState(message: mapFailureToMessage(failure)),
        (driverEntity) => DriverHomeFetchState(driverEntity: driverEntity)));
  }
}

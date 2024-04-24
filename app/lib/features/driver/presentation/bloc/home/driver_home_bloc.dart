import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/features/driver/domain/entities/driver_entity.dart';
import 'package:taxialong/features/driver/domain/entities/go_online_entity.dart';
import 'package:taxialong/features/driver/domain/entities/trip_entity.dart';
import 'package:taxialong/features/driver/domain/usecases/get_driver_data_usecase.dart';
import 'package:taxialong/features/driver/domain/usecases/get_recent_usecase.dart';
import 'package:taxialong/features/driver/domain/usecases/get_request_usecase.dart';
import 'package:taxialong/features/driver/domain/usecases/go_online_usecase.dart';
import 'package:taxialong/features/driver/domain/usecases/update_driver_location_usecase.dart';

part 'driver_home_state.dart';
part 'driver_home_event.dart';

class DriverHomeBloc extends Bloc<DriverHomeEvent, DriverHomeState> {
  GoOnlineUseCase goOnlineUseCase;
  GetDriverDataUseCase getDriverDataUseCase;
  UpdateDriverLocationUseCase updateDriverLocationUseCase;
  GetRecentUseCase getRecentUseCase;
  GetRequestUseCase getRequestUseCase;
  late BitmapDescriptor customIcon;

  List<Marker> markers = <Marker>[];

  DriverHomeBloc({
    required this.getDriverDataUseCase,
    required this.goOnlineUseCase,
    required this.updateDriverLocationUseCase,
    required this.getRecentUseCase,
    required this.getRequestUseCase,
  }) : super(DriverHomeInitailState()) {
    on<DriverHomeGoOnlineEvent>(
        (event, emit) => driverHomeGoOnlineEvent(event, emit));
    on<DriverHomeFetchEvent>(
        (event, emit) => driverHomeFetchEvent(event, emit));
    on<DriverHomeUpdateLocationEvent>(
        (event, emit) => driverUpdateLocationEvent(event, emit));
    on<DriverHomeFetchRequests>(
        (event, emit) => driverHomeFetchRequests(event, emit));
    on<DriverHomeFetchRecents>(
        (event, emit) => driverHomeFetchRecents(event, emit));
  }

  driverHomeFetchRecents(event, emit) async {
    if (event.loading) {
      emit(RecentLoading());
    }

    var failureOrRequestData = await getRecentUseCase({});

    emit(failureOrRequestData.fold(
        (failure) => RecentError(message: mapFailureToMessage(failure)),
        (tripEntity) => RecentLoaded(tripEntity: tripEntity)));
  }

  driverHomeFetchRequests(event, emit) async {
    if (event.loading) {
      emit(RequestLoading());
    }

    var failureOrRequestData = await getRequestUseCase({});

    emit(failureOrRequestData.fold(
        (failure) => RequestError(message: mapFailureToMessage(failure)),
        (tripEntity) => RequestLoaded(tripEntity: tripEntity)));
  }

  driverUpdateLocationEvent(event, emit) async {
    emit(DriverHomeLoadingState());
    customIcon = await createMarkerIcon();
    markers.add(
      Marker(
        icon: customIcon,
        markerId: const MarkerId('driver'),
        position:
            LatLng(double.parse(event.latitude), double.parse(event.longitude)),
      ),
    );

    // update driver location
    await updateDriverLocationUseCase(
      LocationParams(
        latitude: event.latitude,
        longitude: event.longitude,
      ),
    );

    emit(
      DriverHomePositionUpdatedState(
        latitude: event.latitude,
        longitude: event.longitude,
        markers: markers,
      ),
    );
  }

  driverHomeFetchEvent(event, emit) async {
    emit(DriverHomeLoadingState());

    var failureOrDriverData = await getDriverDataUseCase({});

    emit(failureOrDriverData.fold(
        (failure) =>
            DriverHomeErrorState(message: mapFailureToMessage(failure)),
        (driverEntity) => DriverHomeFetchState(driverEntity: driverEntity)));
  }

  driverHomeGoOnlineEvent(event, emit) async {
    var failureOrOnline = await goOnlineUseCase({});

    emit(failureOrOnline.fold(
        (failure) =>
            DriverHomeOnlineError(message: mapFailureToMessage(failure)),
        (goOnlineEntity) =>
            DriverHomeOnlineUpdated(goOnlineEntity: goOnlineEntity)));
  }
}

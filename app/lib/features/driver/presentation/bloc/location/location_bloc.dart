import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/features/driver/domain/usecases/update_driver_location_usecase.dart';

part 'location_state.dart';
part 'location_event.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  UpdateDriverLocationUseCase updateDriverLocationUseCase;
  late BitmapDescriptor customIcon;
  List<Marker> markers = <Marker>[];
  LocationBloc({
    required this.updateDriverLocationUseCase,
  }) : super(LocationInitState()) {
    on<LocationUpdateLocationEvent>(
        (event, emit) => driverUpdateLocationEvent(event, emit));
  }

  driverUpdateLocationEvent(LocationUpdateLocationEvent event, emit) async {
    emit(LocationLoadingState());
    customIcon = await createMarkerIcon();
    markers.add(
      Marker(
        icon: customIcon,
        markerId: const MarkerId('driver'),
        position: LatLng(event.latitude, event.longitude),
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
      LocationPositionUpdatedState(
        latitude: event.latitude,
        longitude: event.longitude,
        markers: markers,
      ),
    );
  }
}

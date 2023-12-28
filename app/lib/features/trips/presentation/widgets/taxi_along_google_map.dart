import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxialong/core/bloc/map/map_bloc.dart';
import 'package:taxialong/core/bloc/web_sockets/pusher/pusher_bloc.dart';
import 'package:taxialong/core/constants/constants.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/features/rides/domain/entities/trip_entity.dart';
import 'package:taxialong/features/trips/presentation/bloc/trip_bloc.dart';

class TaxiAlongGoogleMap extends StatefulWidget {
  final TripEntity trip;
  const TaxiAlongGoogleMap({
    super.key,
    required this.trip,
  });

  @override
  State<TaxiAlongGoogleMap> createState() => _TaxiAlongGoogleMapState();
}

class _TaxiAlongGoogleMapState extends State<TaxiAlongGoogleMap> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  late CameraPosition position;
  late BitmapDescriptor customIcon;
  List<Marker> markers = <Marker>[];
  @override
  void initState() {
    initMarker();
    position = CameraPosition(
      target: LatLng(double.parse(widget.trip.location.latitude),
          double.parse(widget.trip.location.longitude)),
      zoom: googleMapZoomLevel,
    );
    super.initState();
  }

  void initMarker() async {
    customIcon = await createMarkerIcon();
    setState(() {
      markers.add(
        Marker(
          icon: customIcon,
          markerId: const MarkerId('driver'),
          position: LatLng(double.parse(widget.trip.location.latitude),
              double.parse(widget.trip.location.longitude)),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PusherBloc, PusherState>(
      listener: (context, state) {
        if (state is PusherUpdateLocationState) {
          context.read<MapBloc>().add(
                DriverUpdateLocationEvent(
                  latitude: state.latitude,
                  longitude: state.longitude,
                ),
              );
        }
      },
      child: BlocConsumer<MapBloc, MapState>(
        listener: (context, state) {
          double? driverLatitude;
          double? driverLongitude;
          double? currentLatitude;
          double? currentLongitude;
          if (state is DriverLocationUpdatedState) {
            driverLatitude = double.parse(state.latitude);
            driverLongitude = double.parse(state.longitude);
          }
          if (state is MapCurrentPositionState) {
            currentLatitude = double.parse(state.latitude);
            currentLongitude = double.parse(state.longitude);
          }

          // Calculate distance using Haversine formula
          if (driverLatitude != null &&
              driverLongitude != null &&
              currentLatitude != null &&
              currentLongitude != null) {
            final distance = calculateDistance(
              driverLatitude,
              driverLongitude,
              currentLatitude,
              currentLongitude,
            );

            // Determine if positions are close enough based on distance // 50 meters
            if (distance <= 50) {
              // Positions are considered the same
              context.read<TripBloc>().add(UpdatePickUpEvent());
            } else {
              // fire in case outside locaation
              context.read<TripBloc>().add(UpdateCompletedEvent());
            }
          }
        },
        builder: (context, state) {
          if (state is DriverLocationUpdatedState) {
            position = CameraPosition(
              target: LatLng(
                double.parse(state.latitude),
                double.parse(state.longitude),
              ),
              zoom: googleMapZoomLevel,
            );

            markers = state.markers;
          }

          return GoogleMap(
            markers: Set<Marker>.of(markers),
            initialCameraPosition: position,
            zoomControlsEnabled: false,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          );
        },
      ),
    );
  }
}

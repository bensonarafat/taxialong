import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:label_marker/label_marker.dart';
import 'package:taxialong/core/bloc/map/map_bloc.dart';
import 'package:taxialong/core/bloc/web_sockets/pusher/pusher_bloc.dart';
import 'package:taxialong/core/constants/constants.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/features/bus_stops/domain/entities/bus_stop_entity.dart';
import 'package:taxialong/features/trips/domain/entities/trip_entity.dart';
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
  late BitmapDescriptor customIconBusStop;
  Set<Marker> markers = {};
  late LatLng latLng;

  Set<Polyline> polyLine = <Polyline>{};

  List<LatLng> polylineCordinates = [];
  late PolylinePoints polylinePoints;
  @override
  void initState() {
    polylinePoints = PolylinePoints();

    initMarker();
    initDirectionAndWayPoints();
    if (widget.trip.location.latitude != null &&
        widget.trip.location.longitude != null) {
      latLng = LatLng(
          widget.trip.location.latitude!, widget.trip.location.longitude!);
    } else {
      latLng = defaultLatLng;
    }

    position = CameraPosition(
      target: latLng,
      zoom: googleMapZoomLevel,
    );

    super.initState();
  }

  void initDirectionAndWayPoints() async {
    customIconBusStop = await createBusStopIcon();
    List<PolylineWayPoint> waypoints = [];
    List<BusStopEntity> busStops = widget.trip.busStops!;

    for (var i = 0; i < busStops.length; i++) {
      if (i == 24) break;
      double lat = busStops[i].latitude;
      double lng = busStops[i].longitude;
      waypoints.add(PolylineWayPoint(location: '$lat,$lng'));
      setState(() {
        markers.addLabelMarker(
          LabelMarker(
            backgroundColor: primaryColor,
            label: busStops[i].name,
            textStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
                  fontSize: 50,
                  color: white,
                ),
            icon: customIconBusStop,
            infoWindow: InfoWindow(title: busStops[i].name),
            markerId: MarkerId(busStops[i].name),
            position: LatLng(lat, lng),
          ),
        );
      });
    }

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPIKey,
      PointLatLng(
        widget.trip.location.settings?.origin?.latitude ?? defaultLat,
        widget.trip.location.settings?.origin?.longitude ?? defaultLng,
      ),
      PointLatLng(
        widget.trip.location.settings?.destination?.latitude ?? defaultLat,
        widget.trip.location.settings?.destination?.longitude ?? defaultLng,
      ),
      wayPoints: waypoints,
    );
    if (result.status == 'OK') {
      for (var point in result.points) {
        polylineCordinates.add(LatLng(point.latitude, point.longitude));
      }
    }

    setState(() {
      polyLine.add(Polyline(
        jointType: JointType.round,
        polylineId: const PolylineId("route"),
        color: const Color(0xff02294E),
        points: polylineCordinates,
        width: 10,
      ));
    });
  }

  void initMarker() async {
    customIcon = await createMarkerIcon();
    setState(() {
      markers.add(
        Marker(
          icon: customIcon,
          markerId: const MarkerId('driver'),
          position: latLng,
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
            driverLatitude = state.latitude;
            driverLongitude = state.longitude;
          }
          if (state is MapCurrentPositionState) {
            currentLatitude = state.latitude;
            currentLongitude = state.longitude;
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
                state.latitude,
                state.longitude,
              ),
              zoom: googleMapZoomLevel,
            );

            markers = state.markers;
          }

          return GoogleMap(
            polylines: polyLine,
            markers: Set<Marker>.of(markers),
            initialCameraPosition: position,
            zoomControlsEnabled: true,
            zoomGesturesEnabled: true,
            scrollGesturesEnabled: true,
            compassEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          );
        },
      ),
    );
  }
}

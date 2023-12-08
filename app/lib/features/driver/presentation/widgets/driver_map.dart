import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxialong/core/constants/constants.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/features/driver/presentation/bloc/home/driver_home_bloc.dart';

class DriverMap extends StatefulWidget {
  const DriverMap({
    super.key,
  });

  @override
  State<DriverMap> createState() => _DriverMapState();
}

class _DriverMapState extends State<DriverMap> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kLake = CameraPosition(
    target: LatLng(37.43296265331129, -122.08832357078792),
    zoom: 14.4746,
  );
  final List<Marker> _markers = <Marker>[];

  createMarker() async {
    BitmapDescriptor customIcon = await createMarkerIcon();
    _markers.add(
      Marker(
        icon: customIcon,
        markerId: const MarkerId('SomeId'),
        position: defaultLatLng,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    createMarker();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DriverHomeBloc, DriverHomeState>(
        builder: (context, state) {
      return Container(
        padding: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
        ),
        width: 358.w,
        height: 354.h,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
        ),
        child: Stack(
          children: [
            GoogleMap(
              markers: Set<Marker>.of(_markers),
              initialCameraPosition: defaultGoogleMapCameraPosition,
              zoomControlsEnabled: false,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: () => _goToTheLake(),
                child: Container(
                  margin: EdgeInsets.only(
                    right: 11.w,
                    bottom: 9.w,
                  ),
                  width: 38.w,
                  height: 38.h,
                  decoration: const ShapeDecoration(
                    color: primaryColor,
                    shape: OvalBorder(),
                  ),
                  child: const Icon(
                    Icons.gps_fixed,
                    color: white,
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}

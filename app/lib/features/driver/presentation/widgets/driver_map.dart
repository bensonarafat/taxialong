import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxialong/core/bloc/map/map_bloc.dart';
import 'package:taxialong/core/constants/constants.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/core/widgets/taxi_along_loading.dart';
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          BlocBuilder<DriverHomeBloc, DriverHomeState>(
            buildWhen: (previous, state) {
              return state is DriverHomePositionUpdatedState ||
                  state is DriverHomeLoadingState;
            },
            builder: (context, state) {
              if (state is DriverHomePositionUpdatedState) {
                CameraPosition position = CameraPosition(
                  target: LatLng(
                    double.parse(state.latitude),
                    double.parse(state.longitude),
                  ),
                  zoom: googleMapZoomLevel,
                );

                return GoogleMap(
                  markers: Set<Marker>.of(state.markers),
                  initialCameraPosition: position,
                  zoomControlsEnabled: false,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                );
              } else if (state is DriverHomeLoadingState) {
                return Center(
                  child: TaxiAlongLoading(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? white
                        : dark,
                  ),
                );
              } else {
                CameraPosition position = const CameraPosition(
                  target: defaultLatLng,
                  zoom: googleMapZoomLevel,
                );
                return GoogleMap(
                  initialCameraPosition: position,
                  zoomControlsEnabled: false,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                );
              }
            },
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: () =>
                  context.read<MapBloc>().add(MapCurrentPositionEvent()),
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
  }
}

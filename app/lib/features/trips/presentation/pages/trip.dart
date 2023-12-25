import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxialong/core/bloc/map/map_bloc.dart';
import 'package:taxialong/features/rides/domain/entities/confirm_ride_entity.dart';

import 'package:taxialong/features/trips/presentation/widgets/connecting_driver_content.dart';
import 'package:taxialong/features/trips/presentation/widgets/taxi_along_google_map.dart';

class Trip extends StatefulWidget {
  final ConfirmRideEntity confirmRideEntity;
  const Trip({
    super.key,
    required this.confirmRideEntity,
  });

  @override
  State<Trip> createState() => _TripState();
}

class _TripState extends State<Trip> {
  @override
  void initState() {
    context.read<MapBloc>().add(
          GetDriverLocationEvent(
            driverId: widget.confirmRideEntity.trip!.driverId.toString(),
          ),
        );
    super.initState();
  }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(9.0747, 7.4760),
    zoom: 14.4746,
  );

  var dragController = DraggableScrollableController();

  @override
  void dispose() {
    dragController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          TaxiAlongGoogleMap(
            kGooglePlex: _kGooglePlex,
            controller: _controller,
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.4,
            minChildSize: 0.3,
            maxChildSize: 0.8,
            builder: (BuildContext context, ScrollController scrollController) {
              return SingleChildScrollView(
                controller: scrollController,
                child: const BottomSheetViewContent(),
              );
            },
          ),
        ],
      ),
    );
  }
}

/// Content of the DraggableBottomSheet's child SingleChildScrollView
class BottomSheetViewContent extends StatefulWidget {
  const BottomSheetViewContent({super.key});

  @override
  State<BottomSheetViewContent> createState() => _BottomSheetViewContentState();
}

class _BottomSheetViewContentState extends State<BottomSheetViewContent> {
  @override
  Widget build(BuildContext context) {
    double mediaHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: mediaHeight.h,
      child: Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.r),
            topRight: Radius.circular(24.r),
          ),
        ),
        margin: const EdgeInsets.all(0),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: const ConnectingDriverContent()),
      ),
    );
  }
}

class CustomDraggingHandle extends StatelessWidget {
  const CustomDraggingHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5.h,
      width: 30.w,
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey[200]
            : Colors.grey,
        borderRadius: BorderRadius.circular(16.r),
      ),
    );
  }
}

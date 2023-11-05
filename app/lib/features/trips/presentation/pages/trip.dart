import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/features/trips/presentation/widgets/connected_driver_content.dart';
import 'package:taxialong/features/trips/presentation/widgets/connecting_driver_content.dart';
import 'package:taxialong/features/trips/presentation/widgets/map_custom_app_bar.dart';
import 'package:taxialong/features/trips/presentation/widgets/taxi_along_google_map.dart';

class Trip extends StatefulWidget {
  const Trip({super.key});

  @override
  State<Trip> createState() => _TripState();
}

class _TripState extends State<Trip> {
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
          const MapCustomAppBar(),
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

Future<void> connectiondriver() async {
  await Future.delayed(
    const Duration(seconds: 5),
  );
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
        elevation: 12.0,
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
          child: FutureBuilder<void>(
              future: connectiondriver(),
              builder: (context, AsyncSnapshot snap) {
                switch (snap.connectionState) {
                  case ConnectionState.waiting:
                    return const ConnectingDriverContent();
                  case ConnectionState.done:
                    return const ConnectedDriverContent();
                  default:
                    return Container();
                }
              }),
        ),
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
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(16.r),
      ),
    );
  }
}

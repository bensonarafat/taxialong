import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxialong/core/bloc/map/map_bloc.dart';
import 'package:taxialong/features/rides/domain/entities/confirm_ride_entity.dart';
import 'package:taxialong/features/trips/presentation/widgets/connected_driver_content.dart';

class BottomSheetViewContent extends StatefulWidget {
  final ConfirmRideEntity ridedetails;
  const BottomSheetViewContent({
    super.key,
    required this.ridedetails,
  });

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
        child: BlocBuilder<MapBloc, MapState>(
          builder: (BuildContext context, MapState state) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: ConnectedDriverContent(
                ridedetails: widget.ridedetails,
                state: state,
              ),
            );
          },
        ),
      ),
    );
  }
}

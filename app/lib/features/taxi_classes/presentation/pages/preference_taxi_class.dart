import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:taxialong/features/taxi_classes/presentation/widgets/confirm_ride_button.dart';
import 'package:taxialong/features/taxi_classes/presentation/widgets/driver_car.dart';
import 'package:taxialong/features/taxi_classes/presentation/widgets/driver_info.dart';
import 'package:taxialong/features/taxi_classes/presentation/widgets/trip_action.dart';

class PreferenceTaxiClass extends StatelessWidget {
  const PreferenceTaxiClass({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.r),
                topRight: Radius.circular(30.r),
              ),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const DriverCar(),
              Gap(16.h),
              const TripAction(),
              Gap(16.h),
              const DriverInfo(),
              Gap(16.h),
              const ConfirmRideButton(),
            ],
          ),
        ),
      ),
    );
  }
}

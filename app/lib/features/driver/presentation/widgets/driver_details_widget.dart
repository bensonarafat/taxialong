import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/features/driver/domain/entities/driver_entity.dart';
import 'package:taxialong/features/driver/presentation/bloc/home/driver_home_bloc.dart';

class DriverDetailsWidget extends StatelessWidget {
  const DriverDetailsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DriverHomeBloc, DriverHomeState>(
      listener: (context, state) {
        if (state is DriverHomeErrorState) {
          toast(state.message);
        }
      },
      builder: (context, state) {
        String? overallEarning;
        String overallRides = '0';
        String todayRides = '0';
        if (state is DriverHomeErrorState) {
          overallEarning = "---";
        }
        if (state is DriverHomeLoadingState) {
          overallEarning = "--";
        }
        if (state is DriverHomeFetchState) {
          DriverEntity driverEntity = state.driverEntity;
          overallEarning = driverEntity.earningSumAmount;
          overallRides = driverEntity.totalRidesCount;
          todayRides = driverEntity.todayRideCount;
        }

        overallEarning = overallEarning ?? '0.00';
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: ShapeDecoration(
                    color: const Color(0x19DADADA),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r)),
                    shadows: [
                      BoxShadow(
                        color: const Color(0x0C2B3574),
                        blurRadius: 16.r,
                        offset: const Offset(0, 8),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '₦ $overallEarning',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      Gap(4.h),
                      Text(
                        'Overall earnings ',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.robotoFlex(
                          color: const Color(0xFFA0A2A9),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Gap(16.w),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: ShapeDecoration(
                    color: const Color(0x19DADADA),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r)),
                    shadows: [
                      BoxShadow(
                        color: const Color(0x0C2B3574),
                        blurRadius: 16.r,
                        offset: const Offset(0, 8),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          overallRides,
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                      Gap(4.h),
                      Text(
                        'Overall Rides ',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.robotoFlex(
                          color: const Color(0xFFA0A2A9),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Gap(16.w),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: ShapeDecoration(
                    color: const Color(0x19DADADA),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r)),
                    shadows: [
                      BoxShadow(
                        color: const Color(0x0C2B3574),
                        blurRadius: 16.sp,
                        offset: const Offset(0, 8),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        todayRides,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      Gap(4.h),
                      Text(
                        'Today Rides',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.robotoFlex(
                          color: const Color(0xFFA0A2A9),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

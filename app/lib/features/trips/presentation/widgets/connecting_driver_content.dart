import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/features/trips/presentation/widgets/driver_info.dart';
import 'package:taxialong/features/trips/presentation/pages/trip.dart';

class ConnectingDriverContent extends StatefulWidget {
  const ConnectingDriverContent({super.key});

  @override
  State<ConnectingDriverContent> createState() =>
      _ConnectingDriverContentState();
}

class _ConnectingDriverContentState extends State<ConnectingDriverContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(12.h),
        const CustomDraggingHandle(),
        Gap(16.h),
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(16.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: Text(
                          'Getting connected to your driver',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      Gap(3.h),
                      SizedBox(
                        child: Text(
                          'You are welcome to ride with Taxi Along.',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Gap(24.h),
            SizedBox(
              width: 306.w,
              height: 7.h,
              child: LinearProgressIndicator(
                value: 0.5,
                color: const Color(0x561757B6),
                borderRadius: BorderRadius.circular(10),
                valueColor: const AlwaysStoppedAnimation<Color>(primaryColor),
              ),
            ),
            Gap(24.h),
            const DriverInfo(),
            Gap(8.h),
            Container(
              width: 390.w,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: 1.w, color: const Color(0xFFA0A2A9)),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 254.w,
                    height: 42.h,
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                    decoration: ShapeDecoration(
                      color: primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Cancel Ride',
                          style: GoogleFonts.robotoFlex(
                            color: white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}

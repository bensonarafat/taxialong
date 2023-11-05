import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxialong/core/constants/assets.dart';
import 'package:taxialong/core/utils/colors.dart';

class SeatsSelector extends StatelessWidget {
  const SeatsSelector({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        16.0.w,
        16.0.h,
        16.0.w,
        150.0.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gap(24.h),
              Opacity(
                opacity: 0.80,
                child: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: const Color(0x2677787B),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              child: Text(
                                'Selected',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.robotoFlex(
                                  color: white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Gap(8.h),
                            Image.asset(
                              selectedSeat,
                              width: 48.w,
                              height: 48.h,
                            ),
                          ],
                        ),
                      ),
                      Gap(16.w),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              child: Text(
                                'Available',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.robotoFlex(
                                  color: white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Gap(8.h),
                            Image.asset(
                              availableSeat,
                              width: 48.w,
                              height: 48.h,
                            ),
                          ],
                        ),
                      ),
                      Gap(16.w),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              child: Text(
                                'Unavailable',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.robotoFlex(
                                  color: white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Gap(8.h),
                            Image.asset(
                              unavailableSeat,
                              width: 48.w,
                              height: 48.h,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Gap(24.h),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        driverWheels,
                        width: 48.w,
                        height: 48.h,
                      ),
                      Gap(200.w),
                      Image.asset(
                        unavailableSeat,
                        width: 48.w,
                        height: 48.h,
                      ),
                    ],
                  ),
                  Gap(16.h),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        unavailableSeat,
                        width: 48.w,
                        height: 48.h,
                      ),
                      Gap(78.w),
                      Image.asset(
                        unavailableSeat,
                        width: 48.w,
                        height: 48.h,
                      ),
                      Gap(78.w),
                      Image.asset(
                        unavailableSeat,
                        width: 48.w,
                        height: 48.h,
                      ),
                    ],
                  ),
                  Gap(16.h),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        unavailableSeat,
                        width: 48.w,
                        height: 48.h,
                      ),
                      Gap(78.w),
                      Image.asset(
                        unavailableSeat,
                        width: 48.w,
                        height: 48.h,
                      ),
                      Gap(78.w),
                      Image.asset(
                        unavailableSeat,
                        width: 48.w,
                        height: 48.h,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Gap(48.h),
          Container(
            width: double.infinity,
            height: 52.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
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
                  'Continue',
                  style: GoogleFonts.robotoFlex(
                    color: white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    height: 0.10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

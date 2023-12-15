import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:taxialong/core/constants/assets.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/features/rides/domain/entities/seats_entity.dart';

class SeatsSelector extends StatelessWidget {
  final List<SeatsEntity>? seats;
  const SeatsSelector({
    super.key,
    required this.seats,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        16.0.w,
        16.0.h,
        16.0.w,
        16.0.h,
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
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                            Gap(8.h),
                            SvgPicture.asset(
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
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                            Gap(8.h),
                            SvgPicture.asset(
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
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                            Gap(8.h),
                            SvgPicture.asset(
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
                      SvgPicture.asset(
                        driverWheels,
                        width: 48.w,
                        height: 48.h,
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).brightness == Brightness.dark
                              ? white
                              : dark,
                          BlendMode.srcIn,
                        ),
                      ),
                      Gap(78.w),
                      SvgPicture.asset(
                        selectedSeat,
                        width: 48.w,
                        height: 48.h,
                      ),
                      Gap(78.w),
                      SvgPicture.asset(
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
                      SvgPicture.asset(
                        unavailableSeat,
                        width: 48.w,
                        height: 48.h,
                      ),
                      Gap(78.w),
                      SvgPicture.asset(
                        selectedSeat,
                        width: 48.w,
                        height: 48.h,
                      ),
                      Gap(78.w),
                      SvgPicture.asset(
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
                      SvgPicture.asset(
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
        ],
      ),
    );
  }
}

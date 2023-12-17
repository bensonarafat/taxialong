import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:taxialong/core/constants/assets.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/features/rides/domain/entities/seats_entity.dart';

class SeatsSelector extends StatefulWidget {
  final List<SeatsEntity> seats;
  final Function callback;
  const SeatsSelector({
    super.key,
    required this.seats,
    required this.callback,
  });

  @override
  State<SeatsSelector> createState() => _SeatsSelectorState();
}

class _SeatsSelectorState extends State<SeatsSelector> {
  List<Widget> rideseats = [];
  List<dynamic> selectedSeats = [];
  @override
  void initState() {
    appSeats();
    super.initState();
  }

  void appSeats() {
    for (var element in widget.seats) {
      late Widget current;
      if (element.status == 'available') {
        current = InkWell(
          onTap: () {
            selectAndUnselectSeat(element.seat);
          },
          child: SvgPicture.asset(
            availableSeat,
            width: 48.w,
            height: 48.h,
          ),
        );
      }

      if (element.status == 'unavailable') {
        current = SvgPicture.asset(
          unavailableSeat,
          width: 48.w,
          height: 48.h,
        );
      }
      rideseats.insert(element.seat - 1, current);
    }
  }

  selectAndUnselectSeat(seat) {
    setState(() {
      if (selectedSeats.contains(seat)) {
        rideseats[seat - 1] = InkWell(
          onTap: () {
            selectAndUnselectSeat(seat);
          },
          child: SvgPicture.asset(
            availableSeat,
            width: 48.w,
            height: 48.h,
          ),
        );
        selectedSeats.remove(seat);
      } else {
        rideseats[seat - 1] = InkWell(
          onTap: () {
            selectAndUnselectSeat(seat);
          },
          child: SvgPicture.asset(
            selectedSeat,
            width: 48.w,
            height: 48.h,
          ),
        );
        selectedSeats.add(seat);
      }

      widget.callback(selectedSeats);
    });
  }

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
                      rideseats.asMap().containsKey(0)
                          ? rideseats[0]
                          : SvgPicture.asset(
                              unavailableSeat,
                              width: 48.w,
                              height: 48.h,
                            ),
                      Gap(78.w),
                      rideseats.asMap().containsKey(1)
                          ? rideseats[1]
                          : SvgPicture.asset(
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
                      rideseats.asMap().containsKey(2)
                          ? rideseats[2]
                          : SvgPicture.asset(
                              unavailableSeat,
                              width: 48.w,
                              height: 48.h,
                            ),
                      Gap(78.w),
                      rideseats.asMap().containsKey(3)
                          ? rideseats[3]
                          : SvgPicture.asset(
                              unavailableSeat,
                              width: 48.w,
                              height: 48.h,
                            ),
                      Gap(78.w),
                      rideseats.asMap().containsKey(4)
                          ? rideseats[4]
                          : SvgPicture.asset(
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
                      rideseats.asMap().containsKey(5)
                          ? rideseats[5]
                          : SvgPicture.asset(
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

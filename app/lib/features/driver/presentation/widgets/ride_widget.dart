import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxialong/core/constants/assets.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/core/utils/extensions.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/core/widgets/taxi_along_cache_network_image.dart';
import 'package:taxialong/features/driver/domain/entities/trip_entity.dart';

class RideWidget extends StatefulWidget {
  final TripEntity trip;
  const RideWidget({
    super.key,
    required this.trip,
  });

  @override
  State<RideWidget> createState() => _RideWidgetState();
}

class _RideWidgetState extends State<RideWidget> {
  int seats = 1;

  @override
  void initState() {
    List<dynamic> seatList = widget.trip.seats;
    seats = seatList.reduce((a, b) => int.parse(a) + int.parse(b));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 350.w,
          margin: EdgeInsets.only(bottom: 16.h),
          padding: EdgeInsets.all(16.w),
          decoration: ShapeDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? const Color(0xFF121212)
                : const Color(0xFFFAFAFA),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1.w,
                color: const Color(0x5EA0A2A9),
              ),
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        TaxiAlongCachedNetworkImage(
                          path: widget.trip.rider.avatar,
                          width: 52,
                          height: 52,
                          fit: BoxFit.fill,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 1.w, color: const Color(0xFFA0A2A9)),
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        Gap(12.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${widget.trip.rider.firstname} ${widget.trip.rider.lastname}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    fontSize: 16.sp,
                                  ),
                            ),
                            Gap(4.h),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Class ${widget.trip.tripClass}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 12),
                                Container(
                                  width: 17.h,
                                  height: 12.w,
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFFFEDA15),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.r)),
                                  ),
                                ),
                                Gap(12.w),
                                Container(
                                  width: 17.w,
                                  height: 12.h,
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFF0A74D7),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.r)),
                                  ),
                                ),
                              ],
                            ),
                            Gap(4.h),
                            Row(
                              children: [
                                SvgPicture.asset(carSeat),
                                Text(
                                  '$seats Seat',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(children: [
                      GestureDetector(
                        onTap: () async =>
                            uriLauncher('tel:${widget.trip.rider.telephone}'),
                        child: SvgPicture.asset(phoneSVG),
                      ),
                      Gap(10.w),
                      GestureDetector(
                        onTap: () => context.push("/chat"),
                        child: SvgPicture.asset(chatSVG),
                      ),
                    ]),
                  ),
                ],
              ),
              Gap(16.h),
              Row(
                children: [
                  Image.asset(
                    routes,
                    width: 17.w,
                    height: 63.h,
                  ),
                  Gap(9.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.trip.pointa.name,
                          style: Theme.of(context).textTheme.bodyMedium),
                      Gap(12.h),
                      Text(widget.trip.pointb.name,
                          style: Theme.of(context).textTheme.bodyMedium)
                    ],
                  )
                ],
              ),
              Gap(16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '₦${widget.trip.amount}',
                        style: GoogleFonts.robotoFlex(
                          color: primaryColor,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Price',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(cashSVG),
                      Gap(4.w),
                      Text(
                        widget.trip.paymentMethod.inCaps,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

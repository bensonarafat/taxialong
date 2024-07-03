import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxialong/core/bloc/map/map_bloc.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/core/utils/extensions.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/core/widgets/taxi_along_cache_network_image.dart';
import 'package:taxialong/core/widgets/taxi_along_route.dart';

import 'package:taxialong/features/rides/domain/entities/driver_entity.dart';
import 'package:taxialong/features/trips/domain/entities/trip_entity.dart';
import 'package:taxialong/features/trips/presentation/widgets/custom_dragging_handle.dart';
import 'package:taxialong/features/trips/presentation/widgets/driver_details.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class ConnectedDriverContent extends StatefulWidget {
  final TripEntity trip;
  final MapState state;
  const ConnectedDriverContent({
    super.key,
    required this.trip,
    required this.state,
  });

  @override
  State<ConnectedDriverContent> createState() => _ConnectedDriverContentState();
}

class _ConnectedDriverContentState extends State<ConnectedDriverContent> {
  late DriverEntity driver;
  late TripEntity trip;
  @override
  void initState() {
    trip = widget.trip;
    driver = trip.driver!;

    super.initState();
  }

  WoltModalSheetPage showDriverInformation(BuildContext modalSheetContext) {
    return WoltModalSheetPage.withSingleChild(
      hasSabGradient: false,
      isTopBarLayerAlwaysVisible: true,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          16.0.w,
          16.0.h,
          16.0.w,
          150.0.h,
        ),
        child: DriverDetails(
          driver: trip.driver!,
          reviews: trip.reviews!,
        ),
      ),
    );
  }

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
              decoration: BoxDecoration(
                border: Border(
                  bottom:
                      BorderSide(width: 1.w, color: const Color(0xFFA0A2A9)),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 16.w),
                    child: Text(
                      widget.state is TripOnGoingState
                          ? 'Ongoing.....'
                          : 'Your seat(s) has been reservered',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  Gap(3.h),
                  Container(
                    padding: EdgeInsets.only(
                      left: 16.w,
                      bottom: 8.h,
                      top: 8.h,
                    ),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          trip.car.plateNumber,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Gap(16.h),
            Container(
              padding: EdgeInsets.only(
                left: 16.w,
                right: 16.w,
              ),
              child: GestureDetector(
                onTap: () {
                  WoltModalSheet.show<void>(
                    enableDrag: true,
                    context: context,
                    pageListBuilder: (modalSheetContext) {
                      return [
                        showDriverInformation(modalSheetContext),
                      ];
                    },
                    modalTypeBuilder: (context) {
                      return WoltModalType.bottomSheet;
                    },
                    maxDialogWidth: 560.w,
                    minDialogWidth: 400.w,
                    minPageHeight: 0.0,
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              TaxiAlongCachedNetworkImage(
                                url: driver.avatar,
                                width: 65.w,
                                height: 65.h,
                                fit: BoxFit.contain,
                              ),
                              Positioned(
                                bottom: 0,
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    width: 65.w,
                                    decoration: const BoxDecoration(
                                      color: dark,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(25),
                                        bottomRight: Radius.circular(25),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          CupertinoIcons.star_fill,
                                          color: ratingColor,
                                          size: 12,
                                        ),
                                        Gap(2.w),
                                        Text(
                                          "${driver.rating}.0",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall
                                              ?.copyWith(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.bold,
                                                color: white,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Gap(5.w),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  child: Text(
                                    '${driver.firstname} ${driver.lastname}',
                                    maxLines: 1,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Car",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    Gap(4.w),
                                    Text(
                                      trip.car.model,
                                      maxLines: 1,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ],
                                ),
                                Gap(4.h),
                                Row(
                                  children: [
                                    Text(
                                      "Colour:",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    Gap(4.w),
                                    Text(
                                      trip.car.color,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap(16.w),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () async =>
                              uriLauncher('tel:${driver.telephone}'),
                          child: Container(
                            width: 36.w,
                            height: 36.h,
                            decoration: const ShapeDecoration(
                              color: primaryColor,
                              shape: OvalBorder(),
                            ),
                            child: Icon(
                              Icons.phone,
                              color: white,
                              size: 15.w,
                            ),
                          ),
                        ),
                        Gap(10.w),
                        GestureDetector(
                          onTap: () async =>
                              uriLauncher('sms:${driver.telephone}'),
                          child: Container(
                            width: 36.w,
                            height: 36.h,
                            decoration: const ShapeDecoration(
                              color: primaryColor,
                              shape: OvalBorder(),
                            ),
                            child: Icon(
                              Icons.message,
                              color: white,
                              size: 15.w,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Gap(16.h),
            TaxiAlongRoute(
              pointa: trip.pointa.name,
              pointb: trip.pointb.name,
            ),
            Gap(6.h),
            Gap(16.h),
            Padding(
              padding: EdgeInsets.only(
                left: 16.w,
                right: 16.w,
              ),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(8.w),
                decoration: ShapeDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0x19DADADA)
                      : const Color.fromARGB(24, 96, 95, 95),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 46.w,
                      height: 46.h,
                      decoration: const ShapeDecoration(
                        color: white,
                        shape: OvalBorder(),
                      ),
                      child: const Icon(
                        Icons.payments,
                        color: primaryColor,
                      ),
                    ),
                    Gap(16.w),
                    Text(
                      trip.paymentMethod.inCaps,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            Gap(16.h),
            Container(
              padding: EdgeInsets.only(
                left: 16.w,
                right: 16.w,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '₦${trip.amount}',
                        style: GoogleFonts.robotoFlex(
                          color: primaryColor,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Price',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  widget.state is TripOnGoingState
                      ? Container()
                      : GestureDetector(
                          onTap: () {
                            context.push(
                              "/cancel-trip",
                              extra: trip,
                            );
                          },
                          child: Container(
                            width: 120.w,
                            height: 50.h,
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 4.h),
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side:
                                    BorderSide(width: 1.w, color: primaryColor),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                            child: Text(
                              'Cancel Ride',
                              style: GoogleFonts.robotoFlex(
                                color: primaryColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        )
                ],
              ),
            ),
            Gap(32.h),
          ],
        )
      ],
    );
  }
}

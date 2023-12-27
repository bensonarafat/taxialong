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
import 'package:taxialong/features/rides/domain/entities/confirm_ride_entity.dart';
import 'package:taxialong/features/rides/domain/entities/driver_entity.dart';
import 'package:taxialong/features/rides/domain/entities/trip_entity.dart';
import 'package:taxialong/features/trips/presentation/widgets/custom_dragging_handle.dart';
import 'package:taxialong/features/trips/presentation/widgets/driver_details.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class ConnectedDriverContent extends StatefulWidget {
  final ConfirmRideEntity ridedetails;
  final MapState state;
  const ConnectedDriverContent({
    super.key,
    required this.ridedetails,
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
    driver = widget.ridedetails.trip!.driver;
    trip = widget.ridedetails.trip!;
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
          driver: widget.ridedetails.trip!.driver,
          reviews: widget.ridedetails.trip!.reviews,
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
                          : 'You have been connected to your driver',
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
                          'ABC12345',
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
                          TaxiAlongCachedNetworkImage(
                            path: driver.avatar,
                            width: 50,
                            height: 50,
                            fit: BoxFit.fill,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                width: 1,
                                color: primaryColor,
                              ),
                              borderRadius: BorderRadius.circular(100.r),
                            ),
                          ),
                          Gap(35.w),
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
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                                Gap(3.h),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Color(0xffFFC700),
                                    ),
                                    Gap(4.w),
                                    SizedBox(
                                      width: 32.w,
                                      child: Text(
                                        driver.rating,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Gap(32.w),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '10 min. away',
                                  maxLines: 1,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                Gap(4.h),
                                Text(
                                  '2, 5km',
                                  style: Theme.of(context).textTheme.bodyMedium,
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
                          onTap: () {
                            context.push("/chat");
                          },
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
                              extra: widget.ridedetails.trip,
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

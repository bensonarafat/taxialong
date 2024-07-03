import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/core/utils/extensions.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/core/widgets/taxi_along_cache_network_image.dart';
import 'package:taxialong/features/rides/domain/entities/confirm_ride_entity.dart';
import 'package:taxialong/features/rides/domain/entities/rides_entity.dart';
import 'package:taxialong/features/rides/presentation/bloc/ride_bloc.dart';
import 'package:taxialong/features/rides/presentation/widgets/seat_preference.dart';
import 'package:collection/collection.dart';

class ClassRide extends StatefulWidget {
  final RidesEntity rides;
  final String paymentMethod;
  const ClassRide({
    super.key,
    required this.rides,
    required this.paymentMethod,
  });

  @override
  State<ClassRide> createState() => _ClassRideState();
}

class _ClassRideState extends State<ClassRide> {
  List<int> selectedSeats = [];
  Map<String, dynamic>? selectedClass;
  Map<dynamic, dynamic> seats = {};
  @override
  void initState() {
    List<dynamic>? joinedSeats = joinDriver(widget.rides.car.seats);
    seats = groupBy(joinedSeats ?? [], (element) => element['row']);

    super.initState();
  }

  late CancelFunc cancel;

  @override
  Widget build(BuildContext context) {
    return BlocListener<RideBloc, RideState>(
      listenWhen: (pre, state) {
        return state is RideBookErrorState ||
            state is RideBookLoadingState ||
            state is RideBookLoadedState;
      },
      listener: (context, state) {
        if (state is RideBookLoadingState) {
          cancel = BotToast.showLoading();
        }
        if (state is RideBookErrorState) {
          toast(state.message);
          cancel();
        }

        if (state is RideBookLoadedState) {
          ConfirmRideEntity confirmRideEntity = state.confirmRideEntity;
          cancel();
          if (confirmRideEntity.status) {
            context.go("/trip");
          } else {
            toast(confirmRideEntity.message);
          }
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 8.h),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: Color(0x7F77787B)),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      TaxiAlongCachedNetworkImage(
                        url: widget.rides.user.avatar,
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  CupertinoIcons.star_fill,
                                  color: ratingColor,
                                  size: 12,
                                ),
                                Gap(2.w),
                                Text(
                                  "${widget.rides.user.rating}.0",
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
                  Gap(18.w),
                  Expanded(
                    child: SizedBox(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 118.w,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    widget.rides.car.plateNumber.toUpperCase(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                  ),
                                ),
                                Gap(4.w),
                                SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    widget.rides.car.model,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                  ),
                                ),
                                Gap(4.h),
                                Text(
                                  'Colour: ${widget.rides.car.color}',
                                  textAlign: TextAlign.right,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? const Color(0xFFA0A2A9)
                                            : dark,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w300,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Gap(18.w),
                  Expanded(
                    child: Container(
                      height: 42.h,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 4.h,
                      ),
                      decoration: ShapeDecoration(
                        color: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () async {
                          selectedSeats.clear();
                          selectedClass?.clear();

                          if (widget.paymentMethod.toLowerCase() ==
                              widget.rides.settings.paymentMethod
                                  .toLowerCase()) {
                            showSeatPreference(
                                context: context,
                                seats: seats,
                                classes: widget.rides.classes,
                                paymentMethod: widget.paymentMethod,
                                onSelect: (int id) {
                                  bool isContain = selectedSeats.contains(id);
                                  if (isContain) {
                                    selectedSeats.remove(id);
                                  } else {
                                    selectedSeats.add(id);
                                  }
                                },
                                classOnSelect:
                                    (Map<String, dynamic>? classDetails) {
                                  selectedClass = classDetails;
                                },
                                onClosed: () {
                                  if (selectedSeats.isNotEmpty) {
                                    if (selectedClass != null) {
                                      context.read<RideBloc>().add(
                                            RideBookEvent(
                                              seats: selectedSeats,
                                              rideClass: selectedClass!,
                                              driverId:
                                                  widget.rides.car.driverId!,
                                              pointa: widget.rides.pointa,
                                              pointb: widget.rides.pointb,
                                              paymentMethod:
                                                  widget.paymentMethod,
                                              carId: widget.rides.car.id,
                                            ),
                                          );
                                    } else {
                                      toast("You need to select a ride class");
                                    }
                                  } else {
                                    toast(
                                        "You need to select one or more seats");
                                  }
                                });
                          } else {
                            toast(
                              "You can book this class because the driver only accept ${widget.rides.settings.paymentMethod.inCaps} payment",
                            );
                          }
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Select Ride',
                              style: GoogleFonts.robotoFlex(
                                color: white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

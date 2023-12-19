import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxialong/core/constants/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/core/utils/extensions.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/features/rides/domain/entities/confirm_ride_entity.dart';
import 'package:taxialong/features/rides/domain/entities/rides_entity.dart';
import 'package:taxialong/features/rides/presentation/bloc/ride_bloc.dart';
import 'package:taxialong/features/rides/presentation/widgets/seat_preference.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

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
  late CancelFunc cancel;
  void tripSeats(seat) {
    selectedSeats = seat;
  }

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
                  Image.asset(
                    car,
                    width: 65.w,
                    height: 40.h,
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
                                    'Class ${widget.rides.rideClass}',
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
                                    '₦ ${numberFormat(widget.rides.amount)}',
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
                                  widget.rides.paymentMethod.inCaps,
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
                        onTap: () {
                          selectedSeats.clear();

                          if (widget.paymentMethod.toLowerCase() ==
                              widget.rides.paymentMethod.toLowerCase()) {
                            WoltModalSheet.show<void>(
                              enableDrag: true,
                              context: context,
                              pageListBuilder: (context) {
                                return [
                                  selectSeatPreference(
                                    context: context,
                                    seats: widget.rides.seats,
                                    paymentMethod: widget.paymentMethod,
                                    callback: tripSeats,
                                  ),
                                ];
                              },
                              modalTypeBuilder: (context) {
                                return WoltModalType.bottomSheet;
                              },
                              maxDialogWidth: 560.w,
                              minDialogWidth: 400.w,
                              minPageHeight: 0.0,
                            ).then((value) {
                              if (selectedSeats.isNotEmpty) {
                                context.read<RideBloc>().add(
                                      RideBookEvent(
                                        seats: selectedSeats,
                                        amount: widget.rides.amount.toString(),
                                        driverId:
                                            widget.rides.driver.id.toString(),
                                        pointa: widget.rides.pointa.toString(),
                                        pointb: widget.rides.pointb.toString(),
                                        tripClass:
                                            widget.rides.rideClass.toString(),
                                        paymentMethod: widget.paymentMethod,
                                      ),
                                    );
                              }
                            });
                          } else {
                            toast(
                              "You can book this class because the driver only accept ${widget.rides.paymentMethod.inCaps} payment",
                            );
                          }
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Book Ride',
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

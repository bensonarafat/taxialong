import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxialong/core/constants/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/core/utils/extensions.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/features/rides/domain/entities/rides_entity.dart';
import 'package:taxialong/features/rides/presentation/widgets/seat_preference.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class ClassRide extends StatelessWidget {
  final RidesEntity rides;
  const ClassRide({
    super.key,
    required this.rides,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                                  'Class ${rides.rideClass}',
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
                                  '₦ ${numberFormat(rides.amount)}',
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
                                rides.paymentMethod.inCaps,
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
                        WoltModalSheet.show<void>(
                          enableDrag: true,
                          context: context,
                          pageListBuilder: (context) {
                            return [
                              selectSeatPreference(
                                context: context,
                                seats: rides.seats,
                              ),
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
    );
  }
}

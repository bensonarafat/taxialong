import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/features/taxi_classes/presentation/widgets/payment_methods.dart';
import 'package:taxialong/features/taxi_classes/presentation/widgets/seats_selector.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class TripAction extends StatelessWidget {
  const TripAction({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    WoltModalSheetPage selectSeatPreference(
        BuildContext modalSheetContext, TextTheme textTheme) {
      return WoltModalSheetPage.withSingleChild(
        hasSabGradient: false,
        isTopBarLayerAlwaysVisible: true,
        topBarTitle: SizedBox(
          child: Text(
            'Select Seat (s)',
            textAlign: TextAlign.center,
            style: GoogleFonts.robotoFlex(
              color: white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        child: const SeatsSelector(),
      );
    }

    WoltModalSheetPage paymentMethodBottomSheet(
        BuildContext modalSheetContext, TextTheme textTheme) {
      return WoltModalSheetPage.withSingleChild(
        hasSabGradient: false,
        isTopBarLayerAlwaysVisible: true,
        topBarTitle: SizedBox(
          child: Text(
            'Choose a Payment Method',
            textAlign: TextAlign.center,
            style: GoogleFonts.robotoFlex(
              color: white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        child: const PaymentMethod(),
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 1.w, color: const Color(0xFF333333)),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    WoltModalSheet.show<void>(
                      enableDrag: true,
                      context: context,
                      pageListBuilder: (modalSheetContext) {
                        final textTheme = Theme.of(context).textTheme;
                        return [
                          selectSeatPreference(modalSheetContext, textTheme),
                        ];
                      },
                      modalTypeBuilder: (context) {
                        final size = MediaQuery.of(context).size.width;
                        if (size < 768.0) {
                          return WoltModalType.bottomSheet;
                        } else {
                          return WoltModalType.dialog;
                        }
                      },
                      maxDialogWidth: 560.w,
                      minDialogWidth: 400.w,
                      minPageHeight: 0.0,
                      maxPageHeight: 0.9.h,
                    );
                  },
                  child: SizedBox(
                    child: Text(
                      'Select seat preference',
                      style: GoogleFonts.robotoFlex(
                        color: secondaryColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Gap(8.h),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: SizedBox(
                  child: Text(
                    'Cash',
                    style: GoogleFonts.robotoFlex(
                      color: white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Gap(229.w),
              GestureDetector(
                onTap: () {
                  WoltModalSheet.show<void>(
                    enableDrag: true,
                    context: context,
                    pageListBuilder: (modalSheetContext) {
                      final textTheme = Theme.of(context).textTheme;
                      return [
                        paymentMethodBottomSheet(modalSheetContext, textTheme),
                      ];
                    },
                    modalTypeBuilder: (context) {
                      final size = MediaQuery.of(context).size.width;
                      if (size < 768.0) {
                        return WoltModalType.bottomSheet;
                      } else {
                        return WoltModalType.dialog;
                      }
                    },
                    maxDialogWidth: 560.w,
                    minDialogWidth: 400.w,
                    minPageHeight: 0.0,
                    maxPageHeight: 0.9.h,
                  );
                },
                child: const Icon(
                  Icons.keyboard_arrow_down,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Gap(8.h),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: SizedBox(
                  child: Text(
                    'Fare',
                    style: GoogleFonts.robotoFlex(
                      color: white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Gap(227.w),
              Expanded(
                child: SizedBox(
                  child: Text(
                    'N150',
                    textAlign: TextAlign.right,
                    style: GoogleFonts.robotoFlex(
                      color: white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Gap(8.h),
          SizedBox(
            child: Text(
              'Promo code',
              style: GoogleFonts.robotoFlex(
                color: const Color(0xFFA0A2A9),
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

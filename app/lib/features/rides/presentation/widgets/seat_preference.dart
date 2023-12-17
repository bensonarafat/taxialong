import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:taxialong/features/rides/domain/entities/seats_entity.dart';
import 'package:taxialong/features/rides/presentation/widgets/payment_method_widget.dart';
import 'package:taxialong/features/rides/presentation/widgets/confirm_ride_button.dart';
import 'package:taxialong/features/rides/presentation/widgets/seats_selector.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

WoltModalSheetPage selectSeatPreference({
  required BuildContext context,
  required List<SeatsEntity> seats,
  required paymentMethod,
  required Function callback,
}) {
  return WoltModalSheetPage.withSingleChild(
    hasSabGradient: false,
    isTopBarLayerAlwaysVisible: true,
    topBarTitle: SizedBox(
      child: Text(
        'Select Seat (s)',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
      ),
    ),
    child: Column(
      children: [
        SeatsSelector(
          seats: seats,
          callback: callback,
        ),
        Gap(16.h),
        PaymentMethodWidget(
          paymentMethod: paymentMethod,
        ),
        Gap(16.h),
        GestureDetector(
          onTap: () {
            context.pop();
          },
          child: const ConfirmRideButton(),
        ),
        Gap(50.h),
      ],
    ),
  );
}

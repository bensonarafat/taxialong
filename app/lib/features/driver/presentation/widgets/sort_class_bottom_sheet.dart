import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/core/widgets/taxi_along_class_filter.dart';
import 'package:taxialong/core/widgets/taxi_along_wallet_payment_method.dart';
import 'package:taxialong/features/driver/presentation/widgets/save_settings_action_button.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

WoltModalSheetPage sortClassBottomSheet(BuildContext modalSheetContext) {
  return WoltModalSheetPage.withSingleChild(
    hasSabGradient: false,
    topBarTitle: Text(
      "Ride Settings",
      style: Theme.of(modalSheetContext).textTheme.titleLarge!.copyWith(
            fontSize: 20.sp,
          ),
    ),
    stickyActionBar: const SaveSettingsActionButton(),
    isTopBarLayerAlwaysVisible: true,
    child: Padding(
      padding: EdgeInsets.fromLTRB(
        16.0.w,
        16.0.h,
        16.0.w,
        150.0.h,
      ),
      child: Column(
        children: [
          const ClassFilter(),
          const WalletPaymentMethod(),
          Gap(16.h),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Select Terminal Locations',
                  style:
                      Theme.of(modalSheetContext).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                          )),
              Gap(16.h),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 2.w, color: primaryColor),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Starting Point',
                                            style: Theme.of(modalSheetContext)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w700,
                                                ),
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
                          IconTheme(
                            data: Theme.of(modalSheetContext).iconTheme,
                            child: const Icon(
                              Icons.keyboard_arrow_down,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Gap(12.w),
                  Text(
                    'To',
                    style: Theme.of(modalSheetContext)
                        .textTheme
                        .bodyLarge!
                        .copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  Gap(12.w),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 2.w, color: primaryColor),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Ending Point',
                                            style: Theme.of(modalSheetContext)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w700,
                                                ),
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
                          IconTheme(
                            data: Theme.of(modalSheetContext).iconTheme,
                            child: const Icon(
                              Icons.keyboard_arrow_down,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:taxialong/core/widgets/taxi_along_class_filter.dart';
import 'package:taxialong/core/widgets/taxi_along_seats_filter.dart';
import 'package:taxialong/features/taxi_classes/presentation/widgets/fliter_action_button.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

WoltModalSheetPage sortBottomSheet(BuildContext modalSheetContext) {
  return WoltModalSheetPage.withSingleChild(
    hasSabGradient: false,
    stickyActionBar: const FliterActionButton(),
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
          Gap(16.h),
          const SeatsFilter(),
        ],
      ),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/features/taxi_classes/presentation/widgets/class_filter.dart';
import 'package:taxialong/features/taxi_classes/presentation/widgets/fliter_action_button.dart';
import 'package:taxialong/features/taxi_classes/presentation/widgets/seats_filter.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

WoltModalSheetPage sortBottomSheet(
    BuildContext modalSheetContext, TextTheme textTheme) {
  return WoltModalSheetPage.withSingleChild(
    backgroundColor: dark,
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

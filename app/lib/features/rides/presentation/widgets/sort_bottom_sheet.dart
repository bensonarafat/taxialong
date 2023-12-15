import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:taxialong/core/bloc/settings/settings_bloc.dart';
import 'package:taxialong/features/rides/presentation/widgets/rider_class_filter.dart';
import 'package:taxialong/features/rides/presentation/widgets/seats_filter.dart';
import 'package:taxialong/features/rides/presentation/widgets/fliter_action_button.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

WoltModalSheetPage sortBottomSheet({
  required BuildContext context,
  required String pointb,
}) {
  List<dynamic>? classes;
  String seat = '1';
  classesCallback(data) {
    classes = data;
  }

  seatCallback(data) {
    seat = data;
  }

  return WoltModalSheetPage.withSingleChild(
    hasSabGradient: false,
    stickyActionBar: GestureDetector(
      onTap: () {
        context.read<SettingsBloc>().add(
              RideFilterEvent(
                rideClass: classes,
                seat: seat,
              ),
            );

        context.pop();
      },
      child: FliterActionButton(
        pointb: pointb,
      ),
    ),
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
          RiderClassFilter(
            callback: classesCallback,
          ),
          Gap(16.h),
          SeatsFilter(
            callback: seatCallback,
          ),
        ],
      ),
    ),
  );
}

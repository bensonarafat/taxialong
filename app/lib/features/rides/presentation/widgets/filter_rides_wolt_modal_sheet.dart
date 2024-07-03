import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxialong/features/bus_stops/domain/entities/axis_entity.dart';
import 'package:taxialong/features/rides/presentation/widgets/sort_bottom_sheet.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

void filterRidesWoltModelSheet(BuildContext context, AxisEntity busstops) {
  WoltModalSheet.show<void>(
    enableDrag: true,
    context: context,
    pageListBuilder: (context) {
      return [
        sortBottomSheet(
          context: context,
          pointb: busstops.pointb,
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
}

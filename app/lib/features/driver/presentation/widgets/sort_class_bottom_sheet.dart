import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:taxialong/core/domain/entities/settings_entity.dart';
import 'package:taxialong/core/domain/usecases/update_settings_usecase.dart';
import 'package:taxialong/features/driver/presentation/widgets/dirver_select_terminals.dart';
import 'package:taxialong/features/driver/presentation/widgets/driver_class_filter.dart';
import 'package:taxialong/core/widgets/taxi_along_wallet_payment_method.dart';
import 'package:taxialong/features/driver/presentation/widgets/save_settings_action_button.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

WoltModalSheetPage sortClassBottomSheet({
  required BuildContext context,
  required SettingsEntity? settings,
}) {
  List<Map<String, dynamic>>? rideclass = settings?.rideclass;
  String paymentMethod = "cash";
  String? pointa;
  String? pointb;

  if (settings != null) {
    paymentMethod = settings.paymentMethod;

    if (settings.pointa != null) pointa = settings.pointa!;
    if (settings.pointb != null) pointb = settings.pointb!;
  }

  SettingsParams settingsParams = SettingsParams(
    selectedClass: rideclass,
    paymentMethod: paymentMethod,
    pointa: pointa,
    pointb: pointb,
  );
  classesCallback(data) {
    settingsParams.selectedClass = data;
  }

  paymentCallback(data) {
    settingsParams.paymentMethod = data;
  }

  pointaCallback(data) {
    settingsParams.pointa = data.toString();
  }

  pointbCallback(data) {
    settingsParams.pointb = data.toString();
  }

  return WoltModalSheetPage.withSingleChild(
    hasSabGradient: false,
    topBarTitle: Text(
      "Ride Settings",
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: 20.sp,
          ),
    ),
    stickyActionBar: SaveSettingsActionButton(params: settingsParams),
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
          TaxiAlongDriverClassFilter(
            rideClass: rideclass,
            callback: classesCallback,
          ),
          WalletPaymentMethod(
            paymentMethod: paymentMethod,
            callback: paymentCallback,
          ),
          Gap(16.h),
          DriverSelectTerminals(
            pointa: pointa,
            pointb: pointb,
            callbacka: pointaCallback,
            callbackb: pointbCallback,
          ),
        ],
      ),
    ),
  );
}

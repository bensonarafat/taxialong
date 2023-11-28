import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;
import 'package:geolocator/geolocator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:taxialong/core/constants/assets.dart';
import 'package:taxialong/core/services/local_storage.dart';
import 'package:taxialong/core/utils/colors.dart';

double getCollapseOpacity(context) {
  final settings =
      context.dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
  final deltaExtent = settings.maxExtent - settings.minExtent;
  final t = (1.0 - (settings.currentExtent - settings.minExtent) / deltaExtent)
      .clamp(0.0, 1.0);
  final fadeStart = math.max(0.0, 1.0 - kToolbarHeight / deltaExtent);
  const fadeEnd = 1.0;
  final opacity = 1.0 - Interval(fadeStart, fadeEnd).transform(t);
  return opacity;
}

Future<bool> locationEnabled() async {
  return await Geolocator.isLocationServiceEnabled();
}

showEnableLocation(context) async {
  //check if location is enabled
  if (await locationEnabled()) {
    return;
  } else {
    // if this pop has already happend dont show it again
    if (await LocalStorage().getEnableLocation()) return;
    return Alert(
      context: context,
      style: AlertStyle(
        buttonsDirection: ButtonsDirection.column,
        isCloseButton: false,
        titleStyle: Theme.of(context).textTheme.headlineSmall!,
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
          side: const BorderSide(
            color: Color(0xFF121212),
          ),
        ),
        descStyle: Theme.of(context).textTheme.bodyMedium!,
      ),
      image: Image.asset(
        enableLocation,
        width: 97.w,
        height: 97.h,
      ),
      title: "Enable your location",
      desc:
          "Turn On your location to allow “Taxi Along” to Determine Your Location",
      buttons: [
        DialogButton(
          color: Colors.transparent,
          onPressed: () async {
            await enableGeoLocation();
            context.pop();
          },
          child: Container(
            width: 305.w,
            height: 54.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
            decoration: ShapeDecoration(
              color: primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Use current location',
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
        DialogButton(
            color: Colors.transparent,
            onPressed: () => context.pop(),
            child: Container(
              width: 305.w,
              height: 54.h,
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Skip for now',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
            ))
      ],
    ).show();
  }
}

Future<void> enableGeoLocation() async {
  return await Future(() => null);
}

String formatDuration(Duration duration) {
  String twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }

  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

  return "$twoDigitMinutes:$twoDigitSeconds";
}

void toast(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
  );
}

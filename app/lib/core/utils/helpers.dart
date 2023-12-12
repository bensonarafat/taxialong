import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:taxialong/core/constants/assets.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/core/services/local_storage.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/features/home/presentation/bloc/home/home_bloc.dart';

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

showEnableLocation(_) async {
  LocalStorage localStorage = LocalStorage();
  bool? islocationSet = await localStorage.getEnableLocation();
  //check if location is enabled
  if (islocationSet != null) {
    Position? position = await enableGeoLocation();
    if (position != null) {
      // subscribe to
      _.read<HomeBloc>().add(UpdateTerminalEvent(
          latitude: position.latitude.toString(),
          longitude: position.longitude.toString()));
      localStorage.setGeoLocation();
    }
    return;
  } else {
    // if this pop has already happend dont show it again
    if (await locationEnabled()) return;
    return Alert(
      context: _,
      style: AlertStyle(
        buttonsDirection: ButtonsDirection.column,
        isCloseButton: false,
        titleStyle: Theme.of(_).textTheme.headlineSmall!,
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
          side: const BorderSide(
            color: Color(0xFF121212),
          ),
        ),
        descStyle: Theme.of(_).textTheme.bodyMedium!,
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
            Position? position = await enableGeoLocation();
            if (position != null) {
              // subscribe to
              _.read<HomeBloc>().add(UpdateTerminalEvent(
                  latitude: position.latitude.toString(),
                  longitude: position.longitude.toString()));
              localStorage.setGeoLocation();
            }
            Navigator.of(_).pop();
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
            onPressed: () => Navigator.of(_).pop(),
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
                    style: Theme.of(_).textTheme.titleSmall,
                  ),
                ],
              ),
            ))
      ],
    ).show();
  }
}

Future<Position?> enableGeoLocation() async {
  LocationPermission permission;
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      toast('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    toast(
        'Location permissions are permanently denied, we cannot request permissions.');
    return await Geolocator.getCurrentPosition();
  }
  return null;
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

String extractPhoneNumber(String fullNumber) {
  // Define the country code for Nigeria
  const String nigeriaCountryCode = '+234';

  // Check if the number starts with the Nigeria country code
  if (fullNumber.startsWith(nigeriaCountryCode)) {
    // Extract the phone number without the country code
    return fullNumber.substring(nigeriaCountryCode.length);
  } else {
    // The input is not a Nigeria phone number with a country code
    return '080';
  }
}

String mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return 'There was a server error!';
    case CacheFailure:
      return 'Cache Failure';
    case NetworkFailure:
      return 'Network error, check your internet connection';
    default:
      return "Unexpected Error , Please try again later .";
  }
}

Future<BitmapDescriptor> createMarkerIcon() async {
  // make sure to initialize before map loading
  BitmapDescriptor customMarker = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(82, 82)), driverLocation);
  return customMarker;
}

/// Class 1 -> 1 passenger (charter)
/// Class 2 -> Maximum of 2 at the  back. 1 in front
/// Class 3 -> 3 at the back, 1 in front
/// Class 4 -> 3 at the back, 2 in front.
/// Class 5 -> 4 at the back, 2 in front.
List<Map<String, dynamic>> addToClass({
  required List<Map<String, dynamic>>? rideClass,
  required String value,
}) {
  if (rideClass != null) {
    if (value == '1') {
      rideClass.add({"class": 1, "front": 1, "back": 0});
    } else if (value == '2') {
      rideClass.add({"class": 2, "front": 1, "back": 2});
    } else if (value == '3') {
      rideClass.add({"class": 3, "front": 1, "back": 3});
    } else if (value == '4') {
      rideClass.add({"class": 4, "front": 1, "back": 4});
    } else if (value == '5') {
      rideClass.add({"class": 5, "front": 2, "back": 4});
    }
  } else {
    Map<String, dynamic> data = {};
    if (value == '1') {
      data = {"class": 1, "front": 1, "back": 0};
    } else if (value == '2') {
      data = {"class": 2, "front": 1, "back": 2};
    } else if (value == '3') {
      data = {"class": 3, "front": 1, "back": 3};
    } else if (value == '4') {
      data = {"class": 4, "front": 1, "back": 4};
    } else if (value == '5') {
      data = {"class": 5, "front": 2, "back": 4};
    }
    rideClass = [data];
  }
  return rideClass;
}

List<Map<String, dynamic>> removeToClass({
  required List<Map<String, dynamic>>? rideClass,
  required String value,
}) {
  if (rideClass == null) {
    return [];
  } else {
    rideClass.removeWhere((element) => element["class"] == value);
    return rideClass;
  }
}

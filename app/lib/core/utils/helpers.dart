// ignore_for_file: use_build_context_synchronously
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:taxialong/core/bloc/map/map_bloc.dart';
import 'package:taxialong/core/constants/assets.dart';
import 'package:taxialong/core/error/failure.dart';
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

Future<bool> serviceEnabled() async {
  return await Geolocator.isLocationServiceEnabled();
}

showEnableLocation(BuildContext context) async {
  LocalStorage localStorage = LocalStorage();
  bool islocationSet = await localStorage.getEnableLocation();

  //check if location is enabled
  if (islocationSet == true) {
    Position position = await enableGeoLocation();
    // subscribe to

    context.read<MapBloc>().add(
          MapUpdateCurrentPostionEvent(
              latitude: position.latitude.toString(),
              longitude: position.longitude.toString()),
        );
    localStorage.setGeoLocation();
  } else {
    //  Test if location services are enabled.
    if (!await serviceEnabled()) {
      toast("Location services are disabled.");
    } else {
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
              Position? position = await enableGeoLocation();

              // subscribe to
              context.read<MapBloc>().add(MapUpdateCurrentPostionEvent(
                  latitude: position.latitude.toString(),
                  longitude: position.longitude.toString()));
              localStorage.setGeoLocation();

              Navigator.of(context).pop();
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
              onPressed: () => Navigator.of(context).pop(),
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
}

Future<Position> enableGeoLocation() async {
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
  }
  return await Geolocator.getCurrentPosition();
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

double calculateExpandedHeight(GlobalKey contentKey) {
  final RenderBox renderBox =
      contentKey.currentContext?.findRenderObject() as RenderBox;
  final contentHeight = renderBox.size.height;
  return contentHeight + 100;
}

String numberFormat(int amount) {
  NumberFormat formatter = NumberFormat.decimalPatternDigits(
    locale: 'en_us',
    decimalDigits: 2,
  );
  return formatter.format(amount);
}

String readableDate(String date) {
  DateTime dateTime = DateTime.parse(date);
  DateTime now = DateTime.now();
  DateTime today = DateTime(now.year, now.month, now.day);
  String formattedDate;
  if (dateTime.isAfter(today) &&
      dateTime.isBefore(today.add(const Duration(days: 1)))) {
    // If the date is today
    formattedDate = "Today at ${DateFormat.jm().format(dateTime)}";
  } else {
    // For other days
    formattedDate = DateFormat('MMM d, y \'at\' h:mm a').format(dateTime);
  }

  return formattedDate;
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/core/widgets/taxi_along_cache_network_image.dart';
import 'package:taxialong/features/rides/domain/entities/trip_entity.dart';

class Rating extends StatelessWidget {
  final TripEntity trip;
  const Rating({
    super.key,
    required this.trip,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Ratings',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 16.w, right: 16.w),
          child: Container(
            margin: EdgeInsets.only(
              bottom: 75.h,
            ),
            padding: EdgeInsets.only(
              top: 16.h,
              left: 16.w,
              right: 16.w,
              bottom: 16.h,
            ),
            decoration: ShapeDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFF1D1D1D)
                  : white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              shadows: [
                BoxShadow(
                  color: const Color(0x192B3574),
                  blurRadius: 16.r,
                  offset: const Offset(2, 2),
                  spreadRadius: 0.r,
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TaxiAlongCachedNetworkImage(
                  path: trip.driver.avatar,
                  width: 50,
                  height: 50,
                  fit: BoxFit.fill,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      width: 1,
                      color: primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                ),
                Gap(15.h),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${trip.driver.firstname} ${trip.driver.lastname}',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Gap(7.h),
                    Text(
                      ' ABC12345',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                Gap(32.h),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'How was your trip?',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Gap(12.h),
                    Text(
                      'Your feedback will help improve driving experience',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                Gap(32.h),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 0; i < 5; i++)
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                  ],
                ),
                Gap(32.h),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  minLines: 1,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Additional comments.",
                    hintStyle: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                Gap(32.h),
                Container(
                  width: 311.w,
                  height: 42.h,
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
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
                        'Submit review',
                        style: GoogleFonts.robotoFlex(
                          color: white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

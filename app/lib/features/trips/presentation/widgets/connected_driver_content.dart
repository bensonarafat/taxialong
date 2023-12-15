import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxialong/core/constants/assets.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/core/widgets/taxi_along_route.dart';
import 'package:taxialong/features/chat/presentation/pages/chat.dart';
import 'package:taxialong/features/rating/presentation/pages/rating.dart';
import 'package:taxialong/features/trips/presentation/pages/trip.dart';

class ConnectedDriverContent extends StatefulWidget {
  const ConnectedDriverContent({super.key});

  @override
  State<ConnectedDriverContent> createState() => _ConnectedDriverContentState();
}

class _ConnectedDriverContentState extends State<ConnectedDriverContent> {
  bool ongoing = false;
  bool completed = false;

  @override
  void initState() {
    super.initState();
    tripCompleted();
  }

  void tripCompleted() async {
    Future.delayed(const Duration(seconds: 4)).then((value) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => const Rating(),
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(12.h),
        const CustomDraggingHandle(),
        Gap(16.h),
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom:
                      BorderSide(width: 1.w, color: const Color(0xFFA0A2A9)),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 16.w),
                    child: Text(
                      'You have been connected to your driver',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  Gap(3.h),
                  Container(
                    padding: EdgeInsets.only(
                      left: 16.w,
                      bottom: 8.h,
                      top: 8.h,
                    ),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ABC12345',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Gap(16.h),
            Container(
              padding: EdgeInsets.only(
                left: 16.w,
                right: 16.w,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 48.w,
                          height: 48.h,
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            image: const DecorationImage(
                              image: AssetImage(driver),
                              fit: BoxFit.fill,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100.r),
                            ),
                          ),
                        ),
                        const SizedBox(width: 35),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                child: Text(
                                  'Andrew Williams',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                              const SizedBox(height: 3),
                              SizedBox(
                                child: Text(
                                  'Driver ID: 012345',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                              Gap(3.h),
                              SizedBox(
                                child: Text(
                                  'Plate number: ABC12345',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(16.w),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 36.w,
                        height: 36.h,
                        decoration: const ShapeDecoration(
                          color: primaryColor,
                          shape: OvalBorder(),
                        ),
                        child: Icon(
                          Icons.phone,
                          color: white,
                          size: 15.w,
                        ),
                      ),
                      Gap(10.w),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => const Chat()));
                        },
                        child: Container(
                          width: 36.w,
                          height: 36.h,
                          decoration: const ShapeDecoration(
                            color: primaryColor,
                            shape: OvalBorder(),
                          ),
                          child: Icon(
                            Icons.message,
                            color: white,
                            size: 15.w,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Gap(16.h),
            const TaxiAlongRoute(
              pointa: "Abuja",
              pointb: "Lagos",
            ),
            Gap(6.h),
            Container(
              padding: EdgeInsets.only(
                right: 16.w,
              ),
              alignment: Alignment.centerRight,
              child: Text(
                'Change',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: 14.sp,
                    ),
              ),
            ),
            Gap(16.h),
            Padding(
              padding: EdgeInsets.only(
                left: 16.w,
                right: 16.w,
              ),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(8.w),
                decoration: ShapeDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0x19DADADA)
                      : const Color.fromARGB(24, 96, 95, 95),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 46.w,
                      height: 46.h,
                      decoration: const ShapeDecoration(
                        color: white,
                        shape: OvalBorder(),
                      ),
                      child: const Icon(
                        Icons.payments,
                        color: primaryColor,
                      ),
                    ),
                    Gap(16.w),
                    Text(
                      'Cash',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            Gap(16.h),
            Container(
              padding: EdgeInsets.only(
                left: 16.w,
                right: 16.w,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'N150',
                        style: GoogleFonts.robotoFlex(
                          color: primaryColor,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Price',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  Container(
                    width: 120.w,
                    height: 50.h,
                    alignment: Alignment.center,
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1.w, color: primaryColor),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      'Cancel Ride',
                      style: GoogleFonts.robotoFlex(
                        color: primaryColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Gap(32.h),
          ],
        )
      ],
    );
  }
}

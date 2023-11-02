import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:taxialong/core/constants/assets.dart';
import 'package:taxialong/core/utils/colors.dart';

class TaxiAlongRoute extends StatelessWidget {
  const TaxiAlongRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: 16.h,
        bottom: 8.h,
      ),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(218, 218, 218, 0.10),
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(
          color: const Color(0xffD2DDDB),
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: 16.w,
        horizontal: 8.h,
      ),
      child: Row(
        children: [
          Gap(16.w),
          Image.asset(routes),
          Gap(16.w),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Berger Junction",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  color: white,
                ),
              ),
              Gap(8.h),
              Text(
                "Apo Junction",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  color: white,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

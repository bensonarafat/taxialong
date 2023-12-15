import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:taxialong/core/constants/assets.dart';

class TaxiAlongRoute extends StatelessWidget {
  final String pointa;
  final String pointb;
  const TaxiAlongRoute({
    super.key,
    required this.pointa,
    required this.pointb,
  });

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
                pointa,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Gap(8.h),
              Text(
                pointb,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          )
        ],
      ),
    );
  }
}

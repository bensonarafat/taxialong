import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:taxialong/core/utils/colors.dart';

class TaxiAlongRiderClassFilter extends StatelessWidget {
  const TaxiAlongRiderClassFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 58.w,
            child: Text(
              'Class',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? secondaryColor
                        : dark,
                  ),
            ),
          ),
          Gap(8.h),
          SizedBox(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TClass(name: "Class 1"),
                    Gap(16.w),
                    const TClass(name: "Class 2"),
                  ],
                ),
                Gap(16.h),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TClass(name: "Class 3"),
                    Gap(16.w),
                    const TClass(name: "Class 4"),
                  ],
                ),
                Gap(16.h),
                const SizedBox(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TClass(name: "Class 5"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TClass extends StatelessWidget {
  final String name;
  const TClass({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 44.h,
        padding: EdgeInsets.all(10.w),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Radio(
              value: 1,
              groupValue: 1,
              onChanged: (v) {},
            ),
            Gap(10.w),
            Container(
              width: 18,
              height: 18,
              decoration: const ShapeDecoration(
                color: Color(0xFFFEDA15),
                shape: OvalBorder(),
              ),
            ),
            Gap(10.w),
            Expanded(
              child: SizedBox(
                child: Text(
                  name,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:taxialong/core/constants/assets.dart';

class WalletWithdrawal extends StatelessWidget {
  const WalletWithdrawal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 358.w,
      height: 45.h,
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: const Color(0x19DADADA),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            withdrawal,
          ),
          Gap(16.w),
          Expanded(
            child: SizedBox(
              height: 37.h,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Williams',
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                        ),
                        Gap(5.h),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Today at 02:45 pm',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                  letterSpacing: 0.20,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: SizedBox(
                      child: Text(
                        '₦2000.00',
                        textAlign: TextAlign.right,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              height: 0,
                              letterSpacing: 0.20,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

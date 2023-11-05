import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxialong/core/constants/assets.dart';
import 'package:taxialong/core/utils/colors.dart';

class WalletTopUp extends StatelessWidget {
  const WalletTopUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 358,
      height: 45,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0x19DADADA),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            topup,
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
                            'Tony',
                            style: GoogleFonts.robotoFlex(
                              color: white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              height: 0.12.h,
                              letterSpacing: 0.20,
                            ),
                          ),
                        ),
                        Gap(5.h),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Today at 02:45 pm',
                            style: GoogleFonts.robotoFlex(
                              color: const Color(0xFF5A5A5A),
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w400,
                              height: 0,
                              letterSpacing: 0.20.sp,
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
                        style: GoogleFonts.robotoFlex(
                          color: white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          height: 0.10,
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

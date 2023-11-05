import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardGetStartedText extends StatelessWidget {
  const OnboardGetStartedText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 108.h,
      ),
      width: 291.w,
      height: 91.h,
      child: Column(
        children: [
          Text(
            "Get Started",
            style: GoogleFonts.robotoFlex(
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
              color: white,
            ),
          ),
          Text(
            "Choose your comfort level and enjoy a personalized, stress-free ride.",
            textAlign: TextAlign.center,
            style: GoogleFonts.robotoFlex(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: white,
            ),
          ),
        ],
      ),
    );
  }
}

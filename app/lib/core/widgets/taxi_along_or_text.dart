import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrText extends StatelessWidget {
  const OrText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 16.h,
        bottom: 16.h,
      ),
      child: Text(
        "Or".toUpperCase(),
        style: GoogleFonts.robotoFlex(
          fontWeight: FontWeight.w600,
          fontSize: 16.sp,
          color: white,
        ),
      ),
    );
  }
}

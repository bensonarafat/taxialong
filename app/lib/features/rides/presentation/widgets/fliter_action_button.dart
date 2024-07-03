import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FliterActionButton extends StatelessWidget {
  final int pointb;
  const FliterActionButton({
    super.key,
    required this.pointb,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          Container(
            width: 358.w,
            height: 52.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
            decoration: ShapeDecoration(
              color: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Filter',
                  style: GoogleFonts.robotoFlex(
                    color: white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
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

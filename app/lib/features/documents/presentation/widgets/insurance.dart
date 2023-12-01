import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxialong/core/utils/colors.dart';

class Insurance extends StatelessWidget {
  const Insurance({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 358.w,
      padding: EdgeInsets.all(16.w),
      decoration: ShapeDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF121212)
            : const Color(0x4CDADADA),
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1.w, color: const Color(0xFF77787B)),
          borderRadius: BorderRadius.circular(8.r),
        ),
        shadows: [
          BoxShadow(
            color: const Color(0x0C000000),
            blurRadius: 8.r,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
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
                Text(
                  'Insurance',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Gap(4.h),
                Text(
                  'Upload Insurance documents',
                  style: GoogleFonts.robotoFlex(
                    color: const Color(0xFFA0A2A9),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Gap(34.w),
          Container(
            width: 40.w,
            decoration: ShapeDecoration(
              color: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.r),
              ),
            ),
            child: const Icon(
              Icons.upload_file_rounded,
              color: white,
            ),
          ),
        ],
      ),
    );
  }
}

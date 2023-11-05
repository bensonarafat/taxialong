import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchContainer extends StatelessWidget {
  const SearchContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8.w,
      ),
      width: 284.w,
      height: 40.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xff77787B),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            color: white,
            size: 29.sp,
          ),
          Text(
            "Search for a route",
            style: GoogleFonts.robotoFlex(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xffA0A2A9),
            ),
          ),
        ],
      ),
    );
  }
}

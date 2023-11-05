import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxialong/core/utils/colors.dart';

class FirstNameField extends StatelessWidget {
  final TextEditingController firstnameController;
  const FirstNameField({
    super.key,
    required this.firstnameController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 16.w,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "First Name",
            style: GoogleFonts.robotoFlex(
              color: white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 4.h),
          SizedBox(
            width: 358.w,
            height: 44.h,
            child: TextFormField(
              controller: firstnameController,
              decoration: InputDecoration(
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: white,
                  ),
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: white,
                  ),
                ),
                counterText: '',
                hintStyle: GoogleFonts.robotoFlex(
                  color: white,
                  fontSize: 20.0.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

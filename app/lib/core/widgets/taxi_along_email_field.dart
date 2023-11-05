import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxialong/core/utils/colors.dart';

class EmailField extends StatelessWidget {
  final TextEditingController emailController;
  const EmailField({
    super.key,
    required this.emailController,
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
            "Email",
            style: GoogleFonts.robotoFlex(
              color: white,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 4.h),
          SizedBox(
            width: 358.w,
            height: 44.h,
            child: TextFormField(
              controller: emailController,
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
                hintStyle: TextStyle(
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

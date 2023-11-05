import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxialong/features/register/presentation/pages/signup.dart';

class DontHaveAnAccount extends StatelessWidget {
  const DontHaveAnAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 21.h,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SignUp(),
            ),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have an account?",
              style: GoogleFonts.robotoFlex(
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                color: white,
              ),
            ),
            SizedBox(
              width: 5.w,
            ),
            Text(
              "Create Account",
              style: GoogleFonts.robotoFlex(
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                color: primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

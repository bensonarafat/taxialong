import 'package:flutter/material.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxialong/features/login/presentation/pages/login.dart';

class AlreadyHaveAnAccount extends StatelessWidget {
  const AlreadyHaveAnAccount({super.key});

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
              builder: (context) => const Login(),
            ),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Already have an account?",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                color: white,
              ),
            ),
            SizedBox(
              width: 5.w,
            ),
            Text(
              "Login",
              style: TextStyle(
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

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxialong/core/utils/colors.dart';

class CreateAccountButton extends StatelessWidget {
  const CreateAccountButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 33.h,
      ),
      width: 358.w,
      height: 52.h,
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
              side: const BorderSide(
                color: primaryColor,
              ),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
        ),
        child: Text(
          "Create Account",
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: white,
          ),
        ),
        onPressed: () {
          // if (type == "create_account") {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => const CreateAccount(),
          //     ),
          //   );
          // } else {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => const PhoneNumberVerification(),
          //     ),
          //   );
          // }
        },
      ),
    );
  }
}

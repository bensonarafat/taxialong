import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxialong/features/register/presentation/pages/create_account.dart';
import 'package:taxialong/features/register/presentation/pages/phone_number_verification.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxialong/core/utils/colors.dart';

class SignUpNextButton extends StatelessWidget {
  final String? type;
  const SignUpNextButton({
    super.key,
    this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 40.h,
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
          "Next",
          style: GoogleFonts.robotoFlex(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: white,
          ),
        ),
        onPressed: () {
          if (type == "create_account") {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const CreateAccount(),
              ),
            );
          } else {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const PhoneNumberVerification(),
              ),
            );
          }
        },
      ),
    );
  }
}

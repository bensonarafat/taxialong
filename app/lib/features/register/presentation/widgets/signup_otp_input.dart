import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxialong/core/utils/colors.dart';

class SignUpOTPInput extends StatelessWidget {
  final TextEditingController controller;
  final bool autoFocus;
  const SignUpOTPInput(this.controller, this.autoFocus, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56.h,
      width: 60.w,
      child: TextField(
        autofocus: autoFocus,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        controller: controller,
        maxLength: 1,
        cursorColor: Theme.of(context).primaryColor,
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
          hintStyle: GoogleFonts.robotoFlex(color: white, fontSize: 20.0.sp),
        ),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }
}

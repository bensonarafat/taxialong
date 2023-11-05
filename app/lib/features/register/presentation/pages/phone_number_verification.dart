import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/features/register/presentation/widgets/signup_next_button.dart';
import 'package:taxialong/features/register/presentation/widgets/signup_otp_input.dart';

class PhoneNumberVerification extends StatefulWidget {
  const PhoneNumberVerification({super.key});

  @override
  State<PhoneNumberVerification> createState() =>
      _PhoneNumberVerificationState();
}

class _PhoneNumberVerificationState extends State<PhoneNumberVerification> {
  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();
  @override
  void dispose() {
    _fieldOne.dispose();
    _fieldTwo.dispose();
    _fieldThree.dispose();
    _fieldFour.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.chevron_left,
            weight: 24.sp,
          ),
        ),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: 8.h,
                        left: 16.w,
                      ),
                      child: Text(
                        "Verification",
                        style: GoogleFonts.robotoFlex(
                          fontWeight: FontWeight.w600,
                          fontSize: 24.sp,
                          color: const Color(
                            0xfff3f3f3,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 8.h,
                        bottom: 16.h,
                        left: 16.w,
                      ),
                      child: Text(
                        "Verify Mobile Number",
                        style: GoogleFonts.robotoFlex(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                          color: const Color(
                            0xfff3f3f3,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(
                    right: 16.w,
                    left: 16.w,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SignUpOTPInput(_fieldOne, true),
                          SizedBox(width: 38.w),
                          SignUpOTPInput(_fieldTwo, false),
                          SizedBox(width: 38.w),
                          SignUpOTPInput(_fieldThree, false),
                          SizedBox(width: 38.w),
                          SignUpOTPInput(_fieldFour, false)
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 32.h,
                        ),
                        child: Text(
                          "Didn’t receive code?",
                          style: GoogleFonts.robotoFlex(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: white,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 8.h,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Resend code in ",
                              style: GoogleFonts.robotoFlex(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                color: white,
                              ),
                            ),
                            Text(
                              "01:32",
                              style: GoogleFonts.robotoFlex(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SignUpNextButton(type: "create_account"),
                    ],
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

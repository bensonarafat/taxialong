import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/core/widgets/taxi_along_phone_input.dart';
import 'package:taxialong/features/register/presentation/widgets/already_have_account.dart';
import 'package:taxialong/features/register/presentation/widgets/signup_next_button.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

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
      backgroundColor: dark,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: 8.h,
                        left: 16.w,
                      ),
                      child: Text(
                        "Weclome to Taxi Along!",
                        style: TextStyle(
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
                        "Enter mobile number to get started",
                        style: TextStyle(
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
                Column(
                  children: [
                    // phone number widget
                    const PhoneNumberInput(),
                    // phone number widget
                    const SignUpNextButton(),
                    Container(
                      margin: EdgeInsets.only(top: 16.h),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Checkbox(
                              value: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                                side: const BorderSide(
                                  color: white,
                                ),
                              ),
                              onChanged: (v) {},
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: Text(
                              "By signing up confirm that you agree to our Terms of use and Privacy Policy",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                color: white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: AlreadyHaveAnAccount(),
          )
        ],
      ),
    );
  }
}

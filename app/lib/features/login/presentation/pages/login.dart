import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/core/widgets/taxi_along_or_text.dart';
import 'package:taxialong/core/widgets/taxi_along_phone_input.dart';
import 'package:taxialong/core/widgets/taxi_along_social_buttons.dart';
import 'package:taxialong/features/login/presentation/widgets/dont_have_an_account.dart';
import 'package:taxialong/features/login/presentation/widgets/login_account_button.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
                Container(
                  margin: EdgeInsets.only(
                    top: 8.h,
                    left: 16.w,
                  ),
                  child: Text(
                    "Welcome back",
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
                    bottom: 48.h,
                    left: 16.w,
                  ),
                  child: Text(
                    "Login to continue",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                      color: const Color(
                        0xfff3f3f3,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 8.h,
                    left: 16.w,
                    right: 16.w,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Enter Phone Number",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                          color: white,
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      const PhoneNumberInput(),
                    ],
                  ),
                ),
                const Center(child: LoginAccountButton()),
                const Center(child: OrText()),
                const SocialButtons(),
                Container(
                  margin: EdgeInsets.only(
                    top: 21.h,
                  ),
                  child: const DontHaveAnAccount(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

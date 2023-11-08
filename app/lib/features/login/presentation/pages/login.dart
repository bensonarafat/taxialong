import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: IconTheme(
            data: Theme.of(context).iconTheme,
            child: Icon(
              Icons.chevron_left,
              weight: 24.sp,
            ),
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
                Container(
                  margin: EdgeInsets.only(
                    top: 8.h,
                    left: 16.w,
                  ),
                  child: Text(
                    "Welcome back",
                    style: Theme.of(context).textTheme.headlineSmall,
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
                    style: Theme.of(context).textTheme.titleMedium,
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
                        style: Theme.of(context).textTheme.titleSmall,
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

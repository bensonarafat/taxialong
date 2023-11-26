import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/core/widgets/taxi_along_phone_input.dart';
import 'package:taxialong/features/auth/presentation/widgets/already_have_account.dart';
import 'package:taxialong/features/auth/presentation/widgets/phone_next_button.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String? phoneNumber;
  bool checked = true;

  void userNumberFunc(String? number) {
    setState(() {
      phoneNumber = number;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => context.pop(),
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
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: 8.h,
                        left: 16.w,
                      ),
                      child: Text(
                        "Weclome to Taxi Along!",
                        style: Theme.of(context).textTheme.headlineSmall,
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
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    // phone number widget
                    PhoneNumberInput(userNumberFunc: userNumberFunc),
                    // phone number widget
                    PhoneNextButton(
                      telephone: phoneNumber,
                      checked: checked,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16.h),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Checkbox(
                              activeColor: primaryColor,
                              value: checked,
                              onChanged: (v) {
                                setState(() {
                                  checked = v ?? false;
                                });
                              },
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: Text(
                              "By signing up confirm that you agree to our Terms of use and Privacy Policy",
                              style: Theme.of(context).textTheme.titleMedium,
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

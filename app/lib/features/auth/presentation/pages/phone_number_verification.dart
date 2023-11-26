import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:taxialong/features/auth/domain/entities/telephone_entity.dart';
import 'package:taxialong/features/auth/presentation/bloc/countdown/countdown_cubit.dart';
import 'package:taxialong/features/auth/presentation/widgets/otp_count_down.dart';
import 'package:taxialong/features/auth/presentation/widgets/signup_next_button.dart';
import 'package:taxialong/features/auth/presentation/widgets/signup_otp_input.dart';

class PhoneNumberVerification extends StatefulWidget {
  final TelephoneEntity otp;
  const PhoneNumberVerification({
    super.key,
    required this.otp,
  });

  @override
  State<PhoneNumberVerification> createState() =>
      _PhoneNumberVerificationState();
}

class _PhoneNumberVerificationState extends State<PhoneNumberVerification> {
  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();

  late StreamController<String> streamController;

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
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => CountDownCubit(const Duration(minutes: 15)),
          ),
        ],
        child: Stack(
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
                          "Verify Mobile Number",
                          style: Theme.of(context).textTheme.titleMedium,
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
                            "Didn't receive code?",
                            style: Theme.of(context).textTheme.titleSmall,
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
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              OTPCountDown(
                                telephone: widget.otp.telephone,
                              ),
                            ],
                          ),
                        ),
                        SignUpNextButton(
                          uuid: widget.otp.uuid,
                          telephone: widget.otp.telephone,
                          handler: widget.otp.handler,
                          otps: {
                            "fieldOne": _fieldOne.text,
                            "fieldTwo": _fieldTwo.text,
                            "fieldThree": _fieldThree.text,
                            "fieldFour": _fieldFour.text,
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

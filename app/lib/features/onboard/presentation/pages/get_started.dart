import 'package:flutter/material.dart';
import 'package:taxialong/core/constants/assets.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxialong/core/widgets/taxi_along_or_text.dart';
import 'package:taxialong/core/widgets/taxi_along_social_buttons.dart';
import 'package:taxialong/features/onboard/presentation/widgets/onboard_get_started_text.dart';
import 'package:taxialong/features/onboard/presentation/widgets/onboard_login_button.dart';
import 'package:taxialong/features/onboard/presentation/widgets/onboard_sign_up_button.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                top: 135.h,
              ),
              child: Image.asset(
                getStarted,
                fit: BoxFit.contain,
                width: 361.w,
                height: 201.h,
              ),
            ),
            const OnboardGetStartedText(),
            const OnBoardLoginButton(),
            const OnboardSignUpButton(),
            const OrText(),
            const SocialButtons(),
          ],
        ),
      ),
    );
  }
}

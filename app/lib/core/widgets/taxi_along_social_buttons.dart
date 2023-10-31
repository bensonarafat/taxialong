import 'package:flutter/material.dart';
import 'package:taxialong/core/constants/assets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SocialButtons extends StatelessWidget {
  const SocialButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          facebook_icon,
          width: 24.w,
          height: 24.h,
        ),
        SizedBox(
          width: 25.w,
        ),
        Image.asset(
          twitter_icon,
          width: 24.w,
          height: 24.h,
        ),
        SizedBox(
          width: 25.w,
        ),
        Image.asset(
          google_icon,
          width: 24.w,
          height: 24.h,
        ),
      ],
    );
  }
}

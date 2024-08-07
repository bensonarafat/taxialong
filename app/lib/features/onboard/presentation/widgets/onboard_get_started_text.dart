import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardGetStartedText extends StatelessWidget {
  const OnboardGetStartedText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 108.h,
      ),
      width: 291.w,
      child: Column(
        children: [
          Text(
            "Get Started",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Text(
            "Choose your comfort level and enjoy a personalized, stress-free ride.",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}

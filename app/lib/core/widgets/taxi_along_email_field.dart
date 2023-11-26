import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class EmailField extends StatelessWidget {
  final TextEditingController emailController;
  const EmailField({
    super.key,
    required this.emailController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 16.w,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Email",
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Gap(4.h),
          SizedBox(
            width: 358.w,
            height: 60.h,
            child: TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                counterText: '',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FirstNameField extends StatelessWidget {
  final TextEditingController firstnameController;
  const FirstNameField({
    super.key,
    required this.firstnameController,
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
            "First Name",
            style: Theme.of(context).textTheme.titleSmall,
          ),
          SizedBox(height: 4.h),
          SizedBox(
            width: 358.w,
            height: 44.h,
            child: TextFormField(
              controller: firstnameController,
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

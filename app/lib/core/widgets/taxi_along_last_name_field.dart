import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LastNameField extends StatelessWidget {
  final TextEditingController lastnameController;
  const LastNameField({
    super.key,
    required this.lastnameController,
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
            "Last Name",
            style: Theme.of(context).textTheme.titleSmall,
          ),
          SizedBox(height: 4.h),
          SizedBox(
            width: 358.w,
            height: 44.h,
            child: TextFormField(
              controller: lastnameController,
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

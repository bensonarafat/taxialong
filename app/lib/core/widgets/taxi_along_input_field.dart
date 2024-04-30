import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class TaxiAlongInputField extends StatelessWidget {
  final Function(String input) onChange;
  final String label;
  final String? hint;
  const TaxiAlongInputField({
    super.key,
    required this.onChange,
    required this.label,
    this.hint,
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
            label,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Gap(4.h),
          TextFormField(
            onChanged: onChange,
            decoration: InputDecoration(
              helperText: hint,
              counterText: '',
            ),
          ),
        ],
      ),
    );
  }
}

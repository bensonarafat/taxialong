import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CurrentLocationBustop extends StatelessWidget {
  const CurrentLocationBustop({
    super.key,
    required this.status,
  });

  final bool status;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.circle,
          size: 8.w,
          color: status ? const Color(0xff18C161) : const Color(0xffA0A2A9),
        ),
        Gap(8.w),
        Text(
          'Kabusa Junction',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}

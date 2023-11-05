import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxialong/core/utils/colors.dart';

class MapCustomAppBar extends StatelessWidget {
  const MapCustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 52.h, 16.w, 8.h),
      child: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Container(
          width: 36.w,
          height: 36.h,
          decoration: const ShapeDecoration(
            color: primaryColor,
            shape: OvalBorder(),
          ),
          child: const Icon(
            Icons.keyboard_arrow_left,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

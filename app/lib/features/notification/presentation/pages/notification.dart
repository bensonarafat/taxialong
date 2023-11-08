import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxialong/core/constants/assets.dart';
import 'package:taxialong/core/utils/colors.dart';

class TaxiAlongNotification extends StatelessWidget {
  const TaxiAlongNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: const Text(
          'Notification',
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: IconTheme(
            data: Theme.of(context).iconTheme,
            child: const Icon(
              Icons.keyboard_arrow_left,
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 300.w,
              height: 300.h,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(notificationBell),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Gap(16.h),
            Text(
              'No Notifications Available',
              style: GoogleFonts.robotoFlex(
                color: white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }
}

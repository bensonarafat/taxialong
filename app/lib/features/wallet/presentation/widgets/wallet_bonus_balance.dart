import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxialong/core/constants/assets.dart';
import 'package:taxialong/core/utils/colors.dart';

class WalletBonusBalance extends StatelessWidget {
  const WalletBonusBalance({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 16.w,
        horizontal: 4.h,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: primaryColor,
        ),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  right: 4.w,
                  left: 4.w,
                ),
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 111.w,
                      child: Text(
                        "₦500.00",
                        style: GoogleFonts.robotoFlex(
                          color: white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Image.asset(eye),
                  ],
                ),
              ),
            ],
          ),
          Gap(8.h),
          Text(
            "Bonus Balance",
            style: GoogleFonts.robotoFlex(
              fontSize: 14.sp,
              color: white,
              fontWeight: FontWeight.w400,
            ),
          ),
          Gap(16.h),
          Container(
            width: 128.5.w,
            height: 42.h,
            padding: EdgeInsets.only(
              left: 16.w,
              right: 16.w,
            ),
            child: TextButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
              ),
              onPressed: () {},
              child: Text(
                "Fund wallet",
                style: GoogleFonts.robotoFlex(
                  color: white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

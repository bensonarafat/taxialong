import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/core/widgets/taxi_along_loading.dart';

class TaxiAlongButton extends StatelessWidget {
  final Function() onPressed;
  final String buttonText;
  final bool loading;
  final Color? color;
  const TaxiAlongButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.loading = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 358.w,
      height: 60.h,
      child: TextButton(
        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
              side: BorderSide(
                color: color ?? primaryColor,
              ),
            ),
          ),
          backgroundColor:
              WidgetStateProperty.all<Color>(color ?? primaryColor),
        ),
        onPressed: onPressed,
        child: loading
            ? const TaxiAlongLoading()
            : Text(
                buttonText,
                style: GoogleFonts.robotoFlex(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: white,
                ),
              ),
      ),
    );
  }
}

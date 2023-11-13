import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxialong/core/constants/assets.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/features/documents/presentation/widgets/cancel_action_button.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

WoltModalSheetPage uploadDocumentBottomSheet(BuildContext modalSheetContext) {
  return WoltModalSheetPage.withSingleChild(
    topBarTitle: Text(
      'Select upload option',
      style: GoogleFonts.robotoFlex(
        color: white,
        fontSize: 20.sp,
        fontWeight: FontWeight.w400,
      ),
    ),
    hasSabGradient: false,
    stickyActionBar: const CancelUploadActionButton(),
    isTopBarLayerAlwaysVisible: true,
    child: Padding(
      padding: EdgeInsets.fromLTRB(
        16.0.w,
        16.0.h,
        16.0.w,
        150.0.h,
      ),
      child: SizedBox(
        width: 336.w,
        height: 107.h,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 48.h,
              padding: EdgeInsets.all(4.r),
              decoration: BoxDecoration(
                border: Border(
                  bottom:
                      BorderSide(width: 1.w, color: const Color(0xFFA0A2A9)),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    photoCamera,
                    width: 24.w,
                    height: 24.h,
                  ),
                  Gap(4.w),
                  Expanded(
                    child: Text(
                      'Take a photo',
                      style: GoogleFonts.robotoFlex(
                        color: white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Gap(16.h),
            Container(
              width: double.infinity,
              height: 43.h,
              padding: EdgeInsets.all(4.w),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    photoGallery,
                    width: 24.w,
                    height: 24.h,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      'Choose from gallery',
                      style: GoogleFonts.robotoFlex(
                        color: white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

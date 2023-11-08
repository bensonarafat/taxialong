import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:taxialong/core/constants/assets.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/features/driver/presentation/pages/home.dart';

class UploadDocuments2 extends StatelessWidget {
  const UploadDocuments2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: const Text(
          'My Document',
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
      body: Container(
        padding: EdgeInsets.all(16.w),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Column(
                children: [
                  Container(
                    width: 358.w,
                    height: 76.h,
                    padding: EdgeInsets.all(16.w),
                    decoration: ShapeDecoration(
                      color: const Color(0x19DADADA),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.w)),
                      shadows: [
                        BoxShadow(
                          color: const Color(0x0C000000),
                          blurRadius: 8.r,
                          offset: const Offset(0, 4),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Drivers Licence',
                                style: GoogleFonts.robotoFlex(
                                  color: white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Gap(4.h),
                              Text(
                                'Upload drivers licence',
                                style: GoogleFonts.robotoFlex(
                                  color: const Color(0xFFA0A2A9),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Gap(34.w),
                        const Icon(
                          Icons.check,
                          color: primaryColor,
                          size: 40,
                        ),
                      ],
                    ),
                  ),
                  Gap(16.h),
                  Container(
                    width: 358.w,
                    height: 76.h,
                    padding: EdgeInsets.all(16.w),
                    decoration: ShapeDecoration(
                      color: const Color(0x19DADADA),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.w)),
                      shadows: [
                        BoxShadow(
                          color: const Color(0x0C000000),
                          blurRadius: 8.r,
                          offset: const Offset(0, 4),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'National ID Card',
                                style: GoogleFonts.robotoFlex(
                                  color: white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Gap(4.h),
                              Text(
                                'Upload national Id',
                                style: GoogleFonts.robotoFlex(
                                  color: const Color(0xFFA0A2A9),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Gap(34.w),
                        const Icon(
                          Icons.check,
                          color: primaryColor,
                          size: 40,
                        ),
                      ],
                    ),
                  ),
                  Gap(16.h),
                  Container(
                    width: 358.w,
                    height: 76.h,
                    padding: EdgeInsets.all(16.w),
                    decoration: ShapeDecoration(
                      color: const Color(0x19DADADA),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.w)),
                      shadows: [
                        BoxShadow(
                          color: const Color(0x0C000000),
                          blurRadius: 8.r,
                          offset: const Offset(0, 4),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Vehicle Registration',
                                style: GoogleFonts.robotoFlex(
                                  color: white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Gap(4.h),
                              Text(
                                'Upload vehicle registration',
                                style: GoogleFonts.robotoFlex(
                                  color: const Color(0xFFA0A2A9),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Gap(34.w),
                        const Icon(
                          Icons.check,
                          color: primaryColor,
                          size: 40,
                        ),
                      ],
                    ),
                  ),
                  Gap(16.h),
                  Container(
                    width: 358.w,
                    height: 76.h,
                    padding: EdgeInsets.all(16.w),
                    decoration: ShapeDecoration(
                      color: const Color(0x19DADADA),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.w)),
                      shadows: [
                        BoxShadow(
                          color: const Color(0x0C000000),
                          blurRadius: 8.r,
                          offset: const Offset(0, 4),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Insurance',
                                style: GoogleFonts.robotoFlex(
                                  color: white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Gap(4.h),
                              Text(
                                'Upload Insurance documents',
                                style: GoogleFonts.robotoFlex(
                                  color: const Color(0xFFA0A2A9),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Gap(34.w),
                        const Icon(
                          Icons.check,
                          color: primaryColor,
                          size: 40,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  Alert(
                      style: AlertStyle(
                        alertBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          side: const BorderSide(
                            color: Color(0xFF121212),
                          ),
                        ),
                        isCloseButton: false,
                        titleStyle: GoogleFonts.robotoFlex(
                          color: white,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        descStyle: GoogleFonts.robotoFlex(
                          color: white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      context: context,
                      desc:
                          "You have successfully registered as a Taxi Along Driver. You now have a Driver Account. Your details have been received and are being reviewed. Your information has been received and is being examined. You would be informed of the review status within the next 2 working days..",
                      image: SvgPicture.asset(
                        documentsCheck,
                        width: 208.w,
                        height: 208.h,
                      ),
                      buttons: [
                        DialogButton(
                          color: Colors.transparent,
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => const DriverHome()));
                          },
                          child: Container(
                            width: 254.w,
                            height: 42.h,
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 4.h),
                            decoration: ShapeDecoration(
                              color: primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Done',
                                  style: GoogleFonts.robotoFlex(
                                    color: white,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ]).show();
                },
                child: Container(
                  width: 254.w,
                  height: 42.h,
                  margin: EdgeInsets.only(bottom: 34.h),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                  decoration: ShapeDecoration(
                    color: primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Done',
                        style: GoogleFonts.robotoFlex(
                          color: white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

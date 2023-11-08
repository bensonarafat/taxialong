import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxialong/core/constants/assets.dart';
import 'package:taxialong/core/utils/colors.dart';

class Documents extends StatelessWidget {
  const Documents({super.key});

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
                    height: 300.h,
                    padding: EdgeInsets.all(16.w),
                    decoration: ShapeDecoration(
                      color: const Color(0x19DADADA),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r)),
                      shadows: [
                        BoxShadow(
                          color: const Color(0x112B3574),
                          blurRadius: 16.r,
                          offset: const Offset(0, 8),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 358.w,
                          height: 51.h,
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                  ],
                                ),
                              ),
                              Gap(34.w),
                              SizedBox(
                                width: 40.w,
                                height: 40.h,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      top: 0,
                                      child: Container(
                                        width: 40.w,
                                        height: 40.h,
                                        decoration: ShapeDecoration(
                                          color: white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50.r),
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.delete,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Gap(4.h),
                        Container(
                          padding: EdgeInsets.only(
                              top: 20.h, left: 16.w, bottom: 11.h),
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.r)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 308.w,
                                height: 174.h,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(idCard),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ],
                          ),
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
          ],
        ),
      ),
    );
  }
}

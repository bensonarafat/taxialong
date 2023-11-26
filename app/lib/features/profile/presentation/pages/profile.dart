import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxialong/core/constants/assets.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/features/profile/presentation/widgets/profile_logout.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: const Text(
          'Profile',
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Gap(32.h),
            Center(
              child: SizedBox(
                width: 143.w,
                height: 145.h,
                child: Stack(
                  children: [
                    Positioned(
                      left: 7.w,
                      top: 7.h,
                      child: Container(
                        width: 129.w,
                        height: 131.h,
                        decoration: const ShapeDecoration(
                          image: DecorationImage(
                            image: AssetImage(driver),
                            fit: BoxFit.fill,
                          ),
                          shape: OvalBorder(),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 80.w,
                      top: 80.h,
                      child: SizedBox(
                        width: 60.w,
                        height: 60.h,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 11.w,
                              top: 12.37.h,
                              child: SvgPicture.asset(
                                cameraSVG,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Gap(16.h),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      for (int i = 0; i < 5; i++)
                        const Icon(
                          Icons.star,
                          color: Color(0xffF28A1A),
                        ),
                    ],
                  ),
                  Gap(4.h),
                  Text(
                    '5.0',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.robotoFlex(
                      color: primaryColor,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
            Gap(16.h),
            Container(
              padding: EdgeInsets.all(16.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          height: 53,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  width: 0.50.w,
                                  color: const Color(0xFFA0A2A9)),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Full Name',
                                  style:
                                      Theme.of(context).textTheme.titleSmall),
                              Gap(4.h),
                              Text(
                                'Andrew Williams',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                      fontSize: 16.sp,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Gap(16.w),
                      Container(
                        width: 38.50.w,
                        height: 37.81.h,
                        padding: EdgeInsets.only(
                          top: 7.h,
                          left: 7.w,
                          right: 7.50.w,
                          bottom: 6.81.h,
                        ),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.r),
                          ),
                        ),
                        child: const Icon(
                          Icons.edit,
                          color: Color(0xffA0A2A9),
                        ),
                      ),
                    ],
                  ),
                  Gap(16.h),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          height: 53.h,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 0.50.w,
                                color: const Color(0xFFA0A2A9),
                              ),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Phone Number',
                                  style:
                                      Theme.of(context).textTheme.titleSmall),
                              Gap(4.h),
                              Text(
                                '+234 - 08123456789',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                      fontSize: 16.sp,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Gap(16.w),
                      Container(
                        width: 38.50.w,
                        height: 37.81.h,
                        padding: EdgeInsets.only(
                          top: 7.h,
                          left: 7.w,
                          right: 7.50.w,
                          bottom: 6.81.h,
                        ),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        child: const Icon(
                          Icons.edit,
                          color: Color(0xffA0A2A9),
                        ),
                      ),
                    ],
                  ),
                  Gap(16.h),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          height: 53.h,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  width: 0.50.w,
                                  color: const Color(0xFFA0A2A9)),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Email',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              Gap(4.h),
                              Text(
                                'andrew@gmail.com',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                      fontSize: 16.sp,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Gap(16.w),
                      Container(
                        width: 38.50.w,
                        height: 37.81.h,
                        padding: EdgeInsets.only(
                          top: 7.h,
                          left: 7.w,
                          right: 7.50.w,
                          bottom: 6.81.h,
                        ),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        child: const Icon(
                          Icons.edit,
                          color: Color(0xffA0A2A9),
                        ),
                      ),
                    ],
                  ),
                  Gap(16.h),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          height: 53.h,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  width: 0.50.w,
                                  color: const Color(0xFFA0A2A9)),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Password',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              Gap(4.h),
                              Expanded(
                                child: SizedBox(
                                  width: 127.75.w,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 8.w,
                                        height: 8.h,
                                        decoration: ShapeDecoration(
                                          color: Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? white
                                              : dark,
                                          shape: const OvalBorder(),
                                        ),
                                      ),
                                      Gap(4.w),
                                      Container(
                                        width: 8.w,
                                        height: 8.h,
                                        decoration: ShapeDecoration(
                                          color: Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? white
                                              : dark,
                                          shape: const OvalBorder(),
                                        ),
                                      ),
                                      Gap(4.w),
                                      Container(
                                        width: 8.w,
                                        height: 8.h,
                                        decoration: ShapeDecoration(
                                          color: Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? white
                                              : dark,
                                          shape: const OvalBorder(),
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Container(
                                        width: 8.w,
                                        height: 8.h,
                                        decoration: ShapeDecoration(
                                          color: Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? white
                                              : dark,
                                          shape: const OvalBorder(),
                                        ),
                                      ),
                                      Gap(4.w),
                                      Container(
                                        width: 8.w,
                                        height: 8.h,
                                        decoration: ShapeDecoration(
                                          color: Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? white
                                              : dark,
                                          shape: const OvalBorder(),
                                        ),
                                      ),
                                      Gap(4.w),
                                      Container(
                                        width: 8.w,
                                        height: 8.h,
                                        decoration: ShapeDecoration(
                                          color: Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? white
                                              : dark,
                                          shape: const OvalBorder(),
                                        ),
                                      ),
                                      Gap(4.w),
                                      Container(
                                        width: 8.w,
                                        height: 8.h,
                                        decoration: ShapeDecoration(
                                          color: Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? white
                                              : dark,
                                          shape: const OvalBorder(),
                                        ),
                                      ),
                                      Gap(4.w),
                                      Container(
                                        width: 8.w,
                                        height: 8.h,
                                        decoration: ShapeDecoration(
                                          color: Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? white
                                              : dark,
                                          shape: const OvalBorder(),
                                        ),
                                      ),
                                      Gap(4.w),
                                      Container(
                                        width: 8.w,
                                        height: 8.h,
                                        decoration: ShapeDecoration(
                                          color: Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? white
                                              : dark,
                                          shape: const OvalBorder(),
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Container(
                                        width: 8.w,
                                        height: 8.h,
                                        decoration: ShapeDecoration(
                                          color: Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? white
                                              : dark,
                                          shape: const OvalBorder(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Gap(16.w),
                      Container(
                        width: 38.50.w,
                        height: 37.81.h,
                        padding: EdgeInsets.only(
                          top: 7.h,
                          left: 7.w,
                          right: 7.50.w,
                          bottom: 6.81.h,
                        ),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.r),
                          ),
                        ),
                        child: const Icon(
                          Icons.edit,
                          color: Color(0xffA0A2A9),
                        ),
                      ),
                    ],
                  ),
                  Gap(143.h),
                  const ProfileLogout(),
                  Gap(37.h),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxialong/core/constants/assets.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/features/chat/presentation/pages/chat.dart';

class RecentRequest extends StatelessWidget {
  const RecentRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < 5; i++)
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 350.w,
                margin: EdgeInsets.only(bottom: 16.h),
                padding: EdgeInsets.all(16.w),
                decoration: ShapeDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF121212)
                      : const Color(0xFFFAFAFA),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1.w,
                      color: const Color(0x5EA0A2A9),
                    ),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              Container(
                                width: 52.w,
                                height: 52.h,
                                clipBehavior: Clip.antiAlias,
                                decoration: ShapeDecoration(
                                  image: const DecorationImage(
                                    image: AssetImage(driver),
                                    fit: BoxFit.fill,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 1.w,
                                        color: const Color(0xFFA0A2A9)),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                              ),
                              Gap(12.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Lucy Edwin',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontSize: 16.sp,
                                        ),
                                  ),
                                  Gap(4.h),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Class 4',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 12),
                                      Container(
                                        width: 17.h,
                                        height: 12.w,
                                        decoration: ShapeDecoration(
                                          color: const Color(0xFFFEDA15),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4.r)),
                                        ),
                                      ),
                                      Gap(12.w),
                                      Container(
                                        width: 17.w,
                                        height: 12.h,
                                        decoration: ShapeDecoration(
                                          color: const Color(0xFF0A74D7),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4.r)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Gap(4.h),
                                  Row(
                                    children: [
                                      SvgPicture.asset(carSeat),
                                      Text('1 Seat',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium)
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(children: [
                            SvgPicture.asset(phoneSVG),
                            Gap(10.w),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => const Chat()));
                              },
                              child: SvgPicture.asset(chatSVG),
                            ),
                          ]),
                        ),
                      ],
                    ),
                    Gap(16.h),
                    Row(
                      children: [
                        Image.asset(
                          routes,
                          width: 17.w,
                          height: 63.h,
                        ),
                        Gap(9.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Kabusa Junction',
                                style: Theme.of(context).textTheme.bodyMedium),
                            Gap(12.h),
                            Text('Lokogoma Junction',
                                style: Theme.of(context).textTheme.bodyMedium)
                          ],
                        )
                      ],
                    ),
                    Gap(16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'N150',
                              style: GoogleFonts.robotoFlex(
                                color: primaryColor,
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text('Price',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                    ))
                          ],
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(cashSVG),
                            Gap(4.w),
                            Text(
                              'Cash',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
      ],
    );
  }
}

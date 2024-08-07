import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxialong/core/constants/assets.dart';
import 'package:taxialong/core/utils/colors.dart';

class TripHistory extends StatelessWidget {
  const TripHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: const Text(
          'Trip History',
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
        child: Container(
          padding: EdgeInsets.all(16.r),
          child: Column(
            children: [
              for (int i = 1; i < 6; i++)
                Container(
                  margin: EdgeInsets.only(top: 16.h),
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFF121212)
                        : white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.r),
                      topRight: Radius.circular(8.r),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x0A2B3574),
                        blurRadius: 16.r,
                        offset: const Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
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
                          Container(
                            padding: EdgeInsets.all(4.r),
                            decoration: ShapeDecoration(
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? white
                                  : dark,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(width: 1.w, color: white),
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Completed',
                                  style: GoogleFonts.robotoFlex(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? successColor
                                        : white,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              child: Text('02/05/2022',
                                  textAlign: TextAlign.right,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        fontSize: 16.sp,
                                      )),
                            ),
                          ),
                        ],
                      ),
                      Gap(16.h),
                      Row(
                        children: [
                          Image.asset(
                            routes,
                          ),
                          SizedBox(
                            width: 9.w,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Kabusa Junction',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              Gap(14.h),
                              Text(
                                'Lokogoma Junction',
                                style: Theme.of(context).textTheme.titleSmall,
                              )
                            ],
                          ),
                        ],
                      ),
                      Gap(16.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                              Text(
                                'Price',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                width: 40.w,
                                height: 40.h,
                                padding: EdgeInsets.all(4.r),
                                clipBehavior: Clip.antiAlias,
                                decoration: ShapeDecoration(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? const Color(0x19DADADA)
                                      : dark,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                                child: SvgPicture.asset(
                                  cashSVG,
                                  width: 32.w,
                                  height: 32.h,
                                  colorFilter: ColorFilter.mode(
                                    Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? primaryColor
                                        : white,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                              Gap(4.h),
                              Text(
                                'Cash',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                              )
                            ],
                          ),
                        ],
                      ),
                      Gap(16.h),
                      const Divider(
                        color: Color(0xFF77787B),
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
}

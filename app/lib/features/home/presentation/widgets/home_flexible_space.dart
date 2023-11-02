import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:taxialong/core/constants/assets.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/core/widgets/taxi_along_search_container.dart';

class HomeFlexibleSpace extends StatelessWidget {
  const HomeFlexibleSpace({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints box) {
        final opacity = getCollapseOpacity(context);
        return Stack(
          children: [
            Opacity(
              opacity: opacity,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: 60.h,
                    ),
                    child: Image.asset(
                      logodark,
                      width: 108.w,
                      height: 40.h,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 36.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            left: 16.w,
                          ),
                          child: Image.asset(
                            menudark,
                            width: 24.w,
                            height: 20.62.h,
                          ),
                        ),
                        Gap(16.w),
                        const SearchContainer(),
                        Gap(8.w),
                        Container(
                          margin: EdgeInsets.only(
                            right: 16.w,
                          ),
                          child: Image.asset(
                            belldark,
                            height: 26.h,
                            width: 26.w,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 16.h,
                      left: 16.w,
                    ),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Routes",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

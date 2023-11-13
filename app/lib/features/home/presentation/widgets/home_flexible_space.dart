import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:taxialong/core/constants/assets.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/core/widgets/taxi_along_search_container.dart';
import 'package:taxialong/features/notification/presentation/pages/notification.dart';

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
                        Builder(builder: (context) {
                          return Builder(builder: (context) {
                            return GestureDetector(
                              onTap: () {
                                Scaffold.of(context).openDrawer();
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                  left: 16.w,
                                ),
                                child: SvgPicture.asset(
                                  menu,
                                  colorFilter: ColorFilter.mode(
                                    Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? white
                                        : dark,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            );
                          });
                        }),
                        Gap(16.w),
                        const SearchContainer(),
                        Gap(8.w),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => const TaxiAlongNotification()));
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                              right: 16.w,
                            ),
                            child: SvgPicture.asset(
                              notificationSVG,
                              colorFilter: ColorFilter.mode(
                                Theme.of(context).brightness == Brightness.dark
                                    ? white
                                    : dark,
                                BlendMode.srcIn,
                              ),
                            ),
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
                      "Terminals",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w700,
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

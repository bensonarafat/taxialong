import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taxialong/core/constants/assets.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxialong/core/widgets/taxi_along_route.dart';

class RecentStops extends StatelessWidget {
  const RecentStops({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> key = GlobalKey();
    return Scaffold(
      backgroundColor: dark,
      key: key,
      appBar: AppBar(
        backgroundColor: dark,
        elevation: 0,
        title: Image.asset(logodark),
        centerTitle: true,
        leading: Image.asset(
          menudark,
          width: 24.w,
          height: 20.62.h,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                top: 32.h,
              ),
              child: Text(
                "Recent Stops",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: white,
                ),
              ),
            ),
            const TaxiAlongRoute(),
            Container(
              margin: EdgeInsets.only(
                left: 16.w,
                right: 16.w,
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 8.h, bottom: 8.h),
                    child: Row(
                      children: [
                        Image.asset(addroute),
                        Gap(8.w),
                        Text(
                          "Add Route",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Color(0xff333333),
                        ),
                      ),
                    ),
                    padding: EdgeInsets.only(top: 8.h, bottom: 8.h),
                    child: Row(
                      children: [
                        Image.asset(addstop),
                        Gap(8.w),
                        Text(
                          "Add Stop",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:taxialong/core/constants/constants.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/core/widgets/taxi_along_bus_stop.dart';
import 'package:taxialong/features/bus_stops/presentation/widgets/bus_stops_flexible_space.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BusStop extends StatelessWidget {
  const BusStop({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> key = GlobalKey();
    List<String> areas = [
      "Apo Junction",
      "Area 1 Junction",
      "Lokogoma Junction",
      "Garki Junction",
      "Lugbe Junction",
      "Wuye Junction",
      "Jabi Junction",
      "Asokoro Junction",
      "Apo Junction",
      "Area 1 Junction",
      "Lokogoma Junction",
      "Garki Junction",
      "Lugbe Junction",
      "Wuye Junction",
    ];
    return Scaffold(
      key: key,
      backgroundColor: dark,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            backgroundColor: dark,
            expandedHeight: 74.h,
            forceElevated: true,
            flexibleSpace: const BusStopsFlexibleSpace(),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                // areas list
                Container(
                  height: 74.h,
                  padding: EdgeInsets.all(16.w),
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: areas.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        width: 156.w,
                        height: 42.h,
                        margin: EdgeInsets.only(
                          right: 16.w,
                        ),
                        padding: EdgeInsets.all(8.w),
                        decoration: ShapeDecoration(
                          color: index == 0
                              ? primaryColor
                              : const Color(0x19DADADA),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            areas[index],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.w),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1.w),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SizedBox(
                          child: Text(
                            'Bus stops along Apo axis',
                            style: TextStyle(
                              color: white,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
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
                    )),
                  ),
                  padding: EdgeInsets.all(
                    16.w,
                  ),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: busstops.length,
                    itemBuilder: (_, index) {
                      return TaxiAlongBusStops(
                        busstops: busstops,
                        index: index,
                        type: "taxi_classes",
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

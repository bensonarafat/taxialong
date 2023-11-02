import 'package:flutter/material.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxialong/features/taxi_classes/presentation/widgets/class_ride.dart';
import 'package:taxialong/features/taxi_classes/presentation/widgets/taxi_class_flexible_space.dart';

class TaxiClasses extends StatelessWidget {
  const TaxiClasses({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> key = GlobalKey();

    List<Map<String, dynamic>> rides = [
      {},
      {},
      {},
      {},
      {},
      {},
      {},
      {},
      {},
    ];
    return Scaffold(
      key: key,
      backgroundColor: dark,
      body: CustomScrollView(slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          pinned: true,
          elevation: 0,
          backgroundColor: dark,
          expandedHeight: 186.h,
          forceElevated: true,
          flexibleSpace: const TaxiClassFlexibleSpace(),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  border: Border(
                    bottom:
                        BorderSide(width: 1.w, color: const Color(0x7F77787B)),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SizedBox(
                        child: Text(
                          'Available Rides',
                          style: TextStyle(
                            color: white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //rides
              ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: rides.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return const ClassRide();
                },
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

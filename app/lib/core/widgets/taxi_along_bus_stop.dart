import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'package:taxialong/features/bus_stops/presentation/pages/bus_stops.dart';
import 'package:taxialong/features/taxi_classes/presentation/pages/taxi_classes.dart';

class TaxiAlongBusStops extends StatelessWidget {
  final List<String> busstops;
  final int index;
  final String type;
  const TaxiAlongBusStops({
    super.key,
    required this.busstops,
    required this.index,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (type == 'taxi_classes') {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const TaxiClasses()));
        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const BusStop()));
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? const Color.fromRGBO(218, 218, 218, 0.10)
              : const Color.fromARGB(24, 101, 100, 100),
          borderRadius: BorderRadius.circular(8.r),
        ),
        padding: EdgeInsets.all(
          8.w,
        ),
        margin: EdgeInsets.only(
          bottom: 16.h,
        ),
        width: 358.w,
        height: 52.h,
        child: Row(
          children: [
            Text(
              "${index + 1}",
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontSize: 20.sp,
                  ),
            ),
            Gap(4.w),
            Text(
              busstops[index],
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

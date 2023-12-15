import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:taxialong/features/bus_stops/domain/entities/axis_entity.dart';
import 'package:taxialong/features/home/domain/entities/axis_entity.dart'
    as home;

class BusStopsName extends StatelessWidget {
  final AxisEntity busstops;
  final home.AxisEntity terminal;
  final int index;
  const BusStopsName({
    super.key,
    required this.busstops,
    required this.index,
    required this.terminal,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(
          '/rides',
          extra: {"terminal": terminal, "busstops": busstops},
        );
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
              busstops.busStop.name,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

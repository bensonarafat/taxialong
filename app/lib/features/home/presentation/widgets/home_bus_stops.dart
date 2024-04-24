import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:taxialong/features/home/domain/entities/axis_entity.dart';

class HomeTerminals extends StatelessWidget {
  final List<AxisEntity> terminals;
  final int index;
  const HomeTerminals({
    super.key,
    required this.terminals,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(
        "/bus-stop",
        extra: {"index": index, 'terminals': terminals},
      ),
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
              "${terminals[index].terminala.name} along ${terminals[index].terminalb.name}",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

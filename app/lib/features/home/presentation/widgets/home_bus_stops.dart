import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
              ? const Color.fromARGB(24, 101, 100, 100)
              : const Color.fromRGBO(218, 218, 218, 0.10),
          borderRadius: BorderRadius.circular(8.r),
        ),
        padding: EdgeInsets.all(
          16.w,
        ),
        margin: EdgeInsets.only(
          bottom: 16.h,
        ),
        width: 358.w,
        child: Text(
          "${terminals[index].terminala.name} along ${terminals[index].terminalb.name}",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 16.sp,
              ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class TaxiAlongDropDown extends StatelessWidget {
  final Function(String? input) onChange;
  final List<String> items;
  final String label;
  final Widget? moreInfo;
  const TaxiAlongDropDown({
    super.key,
    required this.items,
    required this.label,
    required this.onChange,
    this.moreInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 16.w,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Gap(5.w),
              moreInfo ?? const SizedBox.shrink(),
            ],
          ),
          Gap(4.h),
          DropdownButtonFormField(
            value: items.first,
            items: items.map((String val) {
              return DropdownMenuItem(
                value: val,
                child: Text(
                  val,
                ),
              );
            }).toList(),
            onChanged: onChange,
          ),
        ],
      ),
    );
  }
}

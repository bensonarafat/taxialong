import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:taxialong/core/domain/entities/seats_entity.dart';

class TaxiAlongDropDown extends StatelessWidget {
  final Function(String? input) onChange;
  final List<String> items;
  final String label;
  final Widget? moreInfo;
  final String? value;
  const TaxiAlongDropDown({
    super.key,
    required this.items,
    required this.label,
    required this.onChange,
    this.moreInfo,
    this.value,
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
            value: value ?? items.first,
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

  static buildSeatsDropDown({
    required Function(SeatsEntity? input) onChange,
    required List<SeatsEntity> items,
    required BuildContext context,
    required String label,
    Widget? moreInfo,
    SeatsEntity? value,
  }) {
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
            value: value ?? items.first,
            items: items.map((SeatsEntity val) {
              return DropdownMenuItem(
                value: val,
                child: Text(
                  val.name,
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

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/core/utils/helpers.dart';

class TaxiAlongDriverClassFilter extends StatefulWidget {
  final List<Map<String, dynamic>>? rideClass;
  final Function callback;
  const TaxiAlongDriverClassFilter({
    super.key,
    required this.rideClass,
    required this.callback,
  });

  @override
  State<TaxiAlongDriverClassFilter> createState() =>
      _TaxiAlongDriverClassFilterState();
}

class _TaxiAlongDriverClassFilterState
    extends State<TaxiAlongDriverClassFilter> {
  List<Map<String, dynamic>>? rideClass;
  bool class1 = false;
  bool class2 = false;
  bool class3 = false;
  bool class4 = false;
  bool class5 = false;

  @override
  void initState() {
    rideClass = widget.rideClass;
    if (rideClass != null) {
      if (rideClass!.any((item) => item['class'] == 1)) class1 = true;
      if (rideClass!.any((item) => item['class'] == 2)) class2 = true;
      if (rideClass!.any((item) => item['class'] == 3)) class3 = true;
      if (rideClass!.any((item) => item['class'] == 4)) class4 = true;
      if (rideClass!.any((item) => item['class'] == 5)) class5 = true;
    }
    super.initState();
  }

  selected(action, value) {
    if (!action) {
      //remove;
      rideClass = removeToClass(rideClass: rideClass, value: value);
    } else {
      //add
      rideClass = addToClass(
        rideClass: rideClass,
        value: value,
      );
    }

    widget.callback(rideClass);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 58.w,
            child: Text(
              'Class',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? secondaryColor
                        : dark,
                  ),
            ),
          ),
          Gap(8.h),
          SizedBox(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TClass(
                      nm: "1",
                      name: "Class 1",
                      v: class1,
                      callback: selected,
                    ),
                    Gap(16.w),
                    TClass(
                      nm: "2",
                      name: "Class 2",
                      v: class2,
                      callback: selected,
                    ),
                  ],
                ),
                Gap(16.h),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TClass(
                      nm: "3",
                      name: "Class 3",
                      v: class3,
                      callback: selected,
                    ),
                    Gap(16.w),
                    TClass(
                      nm: "4",
                      name: "Class 4",
                      v: class4,
                      callback: selected,
                    ),
                  ],
                ),
                Gap(16.h),
                SizedBox(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TClass(
                        nm: "5",
                        name: "Class 5",
                        v: class5,
                        callback: selected,
                      ),
                    ],
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

class TClass extends StatefulWidget {
  final String name;
  final bool v;
  final String nm;
  final Function callback;
  const TClass({
    super.key,
    required this.name,
    required this.v,
    required this.callback,
    required this.nm,
  });

  @override
  State<TClass> createState() => _TClassState();
}

class _TClassState extends State<TClass> {
  bool v = false;
  @override
  void initState() {
    v = widget.v;
    super.initState();
  }

  selected(action, value) {
    widget.callback(action, value);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(10.w),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Checkbox(
              value: v,
              onChanged: (val) {
                setState(() {
                  v = val ?? false;
                  selected(v, widget.nm);
                });
              },
            ),
            Gap(10.w),
            Container(
              width: 18.w,
              height: 18.h,
              decoration: const ShapeDecoration(
                color: Color(0xFFFEDA15),
                shape: OvalBorder(),
              ),
            ),
            Gap(10.w),
            Expanded(
              child: SizedBox(
                child: Text(
                  widget.name,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

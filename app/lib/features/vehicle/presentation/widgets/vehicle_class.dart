import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:taxialong/core/utils/colors.dart';

class VehicleClass extends StatefulWidget {
  final Function(dynamic selected, bool? isCheck) callback;
  final List<dynamic> classes;
  final List<dynamic>? selected;
  const VehicleClass({
    super.key,
    required this.classes,
    required this.callback,
    this.selected,
  });

  @override
  State<VehicleClass> createState() => _VehicleClassState();
}

class _VehicleClassState extends State<VehicleClass> {
  List<dynamic> classes = [];
  List<dynamic> selected = [];
  @override
  void initState() {
    classes = widget.classes;
    selected = widget.selected ?? [];

    if (widget.selected != null) {
      //mark as selected
      for (var cl in classes) {
        if (selected.any((element) => element["class"] == cl['class'])) {
          cl['selected'] = true;
        }
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8.w),
      child: GridView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: classes.length ~/ 3,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            mainAxisExtent: 50,
          ),
          itemCount: classes.length,
          itemBuilder: (BuildContext context, int index) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Checkbox(
                    value: classes[index]['selected'],
                    onChanged: (v) {
                      setState(() {
                        classes[index]['selected'] =
                            !classes[index]['selected'];
                        widget.callback(classes[index], v);
                      });
                    }),
                Gap(10.w),
                Container(
                  width: 18.w,
                  height: 18.h,
                  decoration: const ShapeDecoration(
                    color: ratingColor,
                    shape: OvalBorder(),
                  ),
                ),
                Gap(10.w),
                Expanded(
                  child: Text(
                    "Class ${classes[index]['class']}",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            );
          }),
    );
  }
}

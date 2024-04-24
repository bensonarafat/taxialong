import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:taxialong/core/utils/colors.dart';

class SeatsFilter extends StatefulWidget {
  final Function callback;
  const SeatsFilter({
    super.key,
    required this.callback,
  });

  @override
  State<SeatsFilter> createState() => _SeatsFilterState();
}

class _SeatsFilterState extends State<SeatsFilter> {
  String selectedOption = '1';
  selected(seat) {
    setState(() {
      selectedOption = seat;
      widget.callback(seat);
    });
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
            child: Text(
              'Seats',
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
                SizedBox(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Seat(
                        v: "1",
                        name: "1 Seat",
                        callback: selected,
                        selectedoption: selectedOption,
                      ),
                      Gap(16.w),
                      Seat(
                        v: "2",
                        name: "2 Seat",
                        callback: selected,
                        selectedoption: selectedOption,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Gap(8.h),
          SizedBox(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Seat(
                        v: "3",
                        name: "3 Seat",
                        callback: selected,
                        selectedoption: selectedOption,
                      ),
                      Gap(16.w),
                      Seat(
                        v: "4",
                        name: "4 Seat",
                        callback: selected,
                        selectedoption: selectedOption,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Gap(8.h),
          SizedBox(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Seat(
                        v: "5",
                        name: "5 Seat",
                        callback: selected,
                        selectedoption: selectedOption,
                      ),
                      Gap(16.w),
                      Seat(
                        v: "6",
                        name: "6 Seat",
                        callback: selected,
                        selectedoption: selectedOption,
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

class Seat extends StatefulWidget {
  final String name;
  final String selectedoption;
  final Function callback;
  final String v;
  const Seat({
    super.key,
    required this.name,
    required this.callback,
    required this.v,
    required this.selectedoption,
  });

  @override
  State<Seat> createState() => _SeatState();
}

class _SeatState extends State<Seat> {
  selectedFunc(selected) {
    setState(() {
      widget.callback(selected);
    });
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
            Radio(
              value: widget.v,
              groupValue: widget.selectedoption,
              onChanged: (value) {
                setState(() {
                  selectedFunc(value);
                });
              },
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

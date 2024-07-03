import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/core/widgets/taxi_along_button.dart';
import 'package:taxialong/features/rides/presentation/widgets/payment_method_widget.dart';
import 'package:taxialong/features/rides/presentation/widgets/confirm_ride_button.dart';
import 'package:taxialong/features/rides/presentation/widgets/seats_selector.dart';

Future<void> showSeatPreference(
    {required BuildContext context,
    required paymentMethod,
    required Function(int) onSelect,
    required Function(Map<String, dynamic>? classDetails) classOnSelect,
    required Map<dynamic, dynamic> seats,
    required List<dynamic> classes,
    required VoidCallback onClosed}) async {
  showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      enableDrag: true,
      builder: (BuildContext context) {
        return SheetSeatClass(
          paymentMethod: paymentMethod,
          seats: seats,
          onSelect: onSelect,
          classOnSelect: classOnSelect,
          classes: classes,
        );
      }).whenComplete(onClosed);
}

class SheetSeatClass extends StatefulWidget {
  final String paymentMethod;
  final Map<dynamic, dynamic> seats;
  final Function(int) onSelect;
  final Function(Map<String, dynamic>? classDetails) classOnSelect;
  final List<dynamic> classes;
  const SheetSeatClass({
    super.key,
    required this.paymentMethod,
    required this.seats,
    required this.onSelect,
    required this.classes,
    required this.classOnSelect,
  });

  @override
  State<SheetSeatClass> createState() => _SheetSeatClassState();
}

class _SheetSeatClassState extends State<SheetSeatClass> {
  bool show = false;
  Map<String, dynamic>? classSelected;
  List<dynamic> classes = [];

  @override
  void initState() {
    classes = widget.classes;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return show
        ? Column(
            children: [
              Gap(16.h),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          show = false;
                        });
                      },
                      icon: const Icon(Icons.chevron_left),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      'Select Seat (s)',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ],
              ),
              SeatsSelector(
                seats: widget.seats,
                onSelect: widget.onSelect,
                classSelected: classSelected,
              ),
              Gap(16.h),
              PaymentMethodWidget(
                paymentMethod: widget.paymentMethod,
              ),
              Gap(16.h),
              GestureDetector(
                onTap: () {
                  context.pop();
                },
                child: const ConfirmRideButton(),
              ),
              Gap(50.h),
            ],
          )
        : Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                Gap(16.h),
                Text(
                  'Select Ride Class',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Gap(16.h),
                for (dynamic rideclass in classes)
                  GestureDetector(
                    onTap: () {
                      widget.classOnSelect(rideclass);
                      setState(() {
                        classSelected = rideclass;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 8.h),
                      padding: EdgeInsets.symmetric(
                          vertical: 16.h, horizontal: 10.w),
                      decoration: BoxDecoration(
                        color: classSelected != null
                            ? classSelected!['class'] == rideclass['class']
                                ? const Color.fromARGB(71, 158, 158, 158)
                                : null
                            : null,
                        borderRadius: BorderRadius.circular(18.r),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                "assets/images/car.png",
                                width: 70.w,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Class ${rideclass['class']}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w900,
                                        ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.person,
                                        size: 16.w,
                                      ),
                                      Gap(4.w),
                                      Text(
                                        totalAvailable(rideclass['data'])
                                            .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall
                                            ?.copyWith(
                                              fontSize: 14.sp,
                                            ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Text(
                            '₦ ${numberFormat(rideclass['amount'])}',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w900,
                                ),
                          )
                        ],
                      ),
                    ),
                  ),
                Gap(16.h),
                TaxiAlongButton(
                  color: classSelected != null ? null : Colors.grey,
                  onPressed: () {
                    setState(() {
                      if (classSelected != null) {
                        show = true;
                      }
                    });
                  },
                  buttonText: "Next",
                ),
                Gap(50.h),
              ],
            ),
          );
  }

  int totalAvailable(List<dynamic> data) {
    int total = 0;
    for (dynamic row in data) {
      total = row['available'];
    }
    return total;
  }
}

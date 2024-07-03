import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:taxialong/core/constants/assets.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/core/widgets/taxi_along_error_widget.dart';

class SeatsSelector extends StatefulWidget {
  final Function(int id) onSelect;
  final Map<dynamic, dynamic> seats;
  final Map<String, dynamic>? classSelected;
  const SeatsSelector({
    super.key,
    required this.seats,
    required this.onSelect,
    required this.classSelected,
  });

  @override
  State<SeatsSelector> createState() => _SeatsSelectorState();
}

class _SeatsSelectorState extends State<SeatsSelector> {
  late Map<dynamic, dynamic> seats;
  @override
  void initState() {
    seats = widget.seats;
    // seats.forEach((key, value) {
    //   List.generate(value.length, (index) {

    //     Map<String, dynamic> classSelected = widget.classSelected ?? {};
    //     List<dynamic> data = classSelected.isEmpty ? [] : classSelected['data'];
    //     for (var currentclass in data) {
    //       if (currentclass['row'] == value[index]['row']) {
    //         int numberAvailabe = currentclass['available'];
    //         // print("mm> $numberAvailabe");
    //         for (var i = 0; i < (seats.length - numberAvailabe); i++) {
    //           value[i]['status'] = "unavailable";
    //         }
    //       }
    //     }
    //   });
    // });

    super.initState();
  }

  Widget generatedSeats(
    Map<dynamic, dynamic> seats,
    Map<String, dynamic> classSelected,
  ) {
    List<Widget> genSeats = [];
    seats.forEach((key, value) {
      Row rowSeats = Row(
        children: List.generate(
          value.length,
          (index) {
            if (key == 1 && index == 0) {
              // this is the driver
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  driverWheels,
                  width: 60.w,
                  height: 60.h,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).brightness == Brightness.dark
                        ? white
                        : dark,
                    BlendMode.srcIn,
                  ),
                ),
              );
            } else {
              Widget seat;
              if (value[index]['status'] == "available") {
                seat = Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    availableSeat,
                    width: 60.w,
                    height: 60.h,
                  ),
                );
              } else if (value[index]['status'] == "unavailable") {
                seat = Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    unavailableSeat,
                    width: 60.w,
                    height: 60.h,
                  ),
                );
              } else {
                seat = Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    selectedSeat,
                    width: 60.w,
                    height: 60.h,
                  ),
                );
              }

              return GestureDetector(
                onTap: () {
                  setState(() {
                    String status = value[index]['status'];
                    if (status != 'unavailable') {
                      if (status == "available") {
                        value[index]['status'] = "selected";
                      }
                      if (status == "selected") {
                        value[index]['status'] = "available";
                      }
                      widget.onSelect(value[index]['seat']);
                    }
                  });
                },
                child: seat,
              );
            }
          },
        ),
      );
      genSeats.add(rowSeats);
    });
    return Column(
      children: genSeats,
    );
  }

  @override
  Widget build(BuildContext context) {
    // if car seat is null return error Widget
    if (widget.seats.isNotEmpty) {
      return Padding(
        padding: EdgeInsets.fromLTRB(
          16.0.w,
          16.0.h,
          16.0.w,
          16.0.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap(24.h),
                Opacity(
                  opacity: 0.80,
                  child: Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: const Color(0x2677787B),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                child: Text(
                                  'Selected',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                              Gap(8.h),
                              SvgPicture.asset(
                                selectedSeat,
                                width: 48.w,
                                height: 48.h,
                              ),
                            ],
                          ),
                        ),
                        Gap(16.w),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                child: Text(
                                  'Available',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                              Gap(8.h),
                              SvgPicture.asset(
                                availableSeat,
                                width: 48.w,
                                height: 48.h,
                              ),
                            ],
                          ),
                        ),
                        Gap(16.w),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                child: Text(
                                  'Unavailable',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                              Gap(8.h),
                              SvgPicture.asset(
                                unavailableSeat,
                                width: 48.w,
                                height: 48.h,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Gap(24.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: generatedSeats(
                    seats,
                    widget.classSelected ?? {},
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } else {
      return const TaxiAlongErrorWidget();
    }
  }
}

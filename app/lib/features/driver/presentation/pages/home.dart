import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxialong/core/constants/assets.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/core/widgets/taxi_along_drawer.dart';
import 'package:taxialong/features/driver/presentation/widgets/driver_flexible_space.dart';
import 'package:taxialong/features/driver/presentation/widgets/driver_map.dart';
import 'package:taxialong/features/driver/presentation/widgets/new_request.dart';
import 'package:taxialong/features/driver/presentation/widgets/recent_request.dart';
import 'package:taxialong/features/driver/presentation/widgets/sort_class_bottom_sheet.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class DriverHome extends StatefulWidget {
  const DriverHome({super.key});

  @override
  State<DriverHome> createState() => _DriverHomeState();
}

class _DriverHomeState extends State<DriverHome> {
  bool status = false;

  void toggleOnOff() {
    setState(() {
      status = !status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
        child: TaxiAlongDrawer(),
      ),
      body: CustomScrollView(slivers: [
        SliverAppBar(
          shadowColor: Theme.of(context).shadowColor,
          surfaceTintColor: Theme.of(context).colorScheme.background,
          backgroundColor: Theme.of(context).colorScheme.background,
          elevation: 0,
          automaticallyImplyLeading: false,
          pinned: false,
          floating: true,
          expandedHeight: 100.h,
          forceElevated: true,
          flexibleSpace: DriverFlexibleSpace(action: toggleOnOff),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Container(
                padding: EdgeInsets.only(
                  left: 16.w,
                  right: 16.w,
                  top: 16.h,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 48.w,
                          height: 48.h,
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            image: const DecorationImage(
                              image: AssetImage(driver),
                              fit: BoxFit.fill,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100.r),
                            ),
                          ),
                        ),
                        Gap(12.w),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hi Andrew Williams',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Gap(2.h),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.circle,
                                  size: 8.w,
                                  color: status
                                      ? const Color(0xff18C161)
                                      : const Color(0xffA0A2A9),
                                ),
                                Gap(8.w),
                                Text(
                                  'Kabusa Junction',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        WoltModalSheet.show<void>(
                          enableDrag: true,
                          context: context,
                          pageListBuilder: (modalSheetContext) {
                            return [
                              sortClassBottomSheet(modalSheetContext),
                            ];
                          },
                          modalTypeBuilder: (context) {
                            final size = MediaQuery.of(context).size.width;
                            if (size < 768.0) {
                              return WoltModalType.bottomSheet;
                            } else {
                              return WoltModalType.dialog;
                            }
                          },
                          maxDialogWidth: 560.w,
                          minDialogWidth: 400.w,
                          minPageHeight: 0.0,
                        );
                      },
                      child: Container(
                        width: 94.w,
                        height: 40.h,
                        padding: EdgeInsets.all(8.r),
                        decoration: ShapeDecoration(
                          color:
                              status ? primaryColor : const Color(0xffA0A2A9),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.r)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Class',
                              style: GoogleFonts.robotoFlex(
                                color: white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Gap(4.w),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: white,
                              size: 24.w,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Gap(24.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(8.r),
                        decoration: ShapeDecoration(
                          color: const Color(0x19DADADA),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r)),
                          shadows: [
                            BoxShadow(
                              color: const Color(0x0C2B3574),
                              blurRadius: 16.r,
                              offset: const Offset(0, 8),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'N 20,000',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            Gap(4.h),
                            Text(
                              'Overall earnings ',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.robotoFlex(
                                color: const Color(0xFFA0A2A9),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Gap(16.w),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(8.r),
                        decoration: ShapeDecoration(
                          color: const Color(0x19DADADA),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r)),
                          shadows: [
                            BoxShadow(
                              color: const Color(0x0C2B3574),
                              blurRadius: 16.r,
                              offset: const Offset(0, 8),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                '126',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                            Gap(4.h),
                            Text(
                              'Overall Rides ',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.robotoFlex(
                                color: const Color(0xFFA0A2A9),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Gap(16.w),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(8.r),
                        decoration: ShapeDecoration(
                          color: const Color(0x19DADADA),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r)),
                          shadows: [
                            BoxShadow(
                              color: const Color(0x0C2B3574),
                              blurRadius: 16.sp,
                              offset: const Offset(0, 8),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '5',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            Gap(4.h),
                            Text(
                              'Today Rides',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.robotoFlex(
                                color: const Color(0xFFA0A2A9),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Gap(24.h),
              const DriverMap(),
              Gap(16.h),
              !status
                  ? Container(
                      padding: EdgeInsets.only(
                        left: 16.w,
                        right: 16.w,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              'Recent Request',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                          ),
                          Gap(20.w),
                          SizedBox(
                            width: 99.w,
                            height: 21.h,
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'View ',
                                    style: GoogleFonts.robotoFlex(
                                      color: const Color(0xFF717171),
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'all',
                                    style: GoogleFonts.robotoFlex(
                                      color: const Color(0xFF717171),
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(),
              !status ? Gap(16.h) : Container(),

              //
              status ? const DriverTrips() : const RecentRequest(),
            ],
          ),
        ),
      ]),
    );
  }
}

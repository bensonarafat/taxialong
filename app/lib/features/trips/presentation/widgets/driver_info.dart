import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:taxialong/core/constants/assets.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class DriverInfo extends StatelessWidget {
  const DriverInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    WoltModalSheetPage showDriverInformation(BuildContext modalSheetContext) {
      return WoltModalSheetPage.withSingleChild(
        hasSabGradient: false,
        isTopBarLayerAlwaysVisible: true,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            16.0.w,
            16.0.h,
            16.0.w,
            150.0.h,
          ),
          child: const AllDriver(),
        ),
      );
    }

    return Container(
      decoration: ShapeDecoration(
        color: const Color(0x19DADADA),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      margin: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
      ),
      child: GestureDetector(
        onTap: () {
          WoltModalSheet.show<void>(
            enableDrag: true,
            context: context,
            pageListBuilder: (modalSheetContext) {
              return [
                showDriverInformation(modalSheetContext),
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
        child: const DriverWidget(),
      ),
    );
  }
}

class DriverWidget extends StatelessWidget {
  const DriverWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: ShapeDecoration(
        color: const Color(0x19DADADA),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1.w,
            color: const Color(0xFF333333),
          ),
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: 48.w,
            height: 48.h,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              image: const DecorationImage(
                image: AssetImage(
                  driver,
                ),
                fit: BoxFit.fill,
              ),
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  width: 1,
                  color: primaryColor,
                ),
                borderRadius: BorderRadius.circular(100.r),
              ),
            ),
          ),
          Gap(12.w),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Andrew Williams',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        Gap(4.h),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.star,
                              color: Color(0xffFFC700),
                            ),
                            Gap(4.w),
                            SizedBox(
                              width: 32.w,
                              child: Text(
                                '4.7',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Gap(32.w),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '10 min. away',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Gap(4.h),
                        Text(
                          '2, 5km',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AllDriver extends StatelessWidget {
  const AllDriver({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const DriverWidget(),
        Gap(8.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.w, color: const Color(0xFF333333)),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Contact Information:',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              Gap(20.h),
              Text(
                'Phone Number: +234 8123456789',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Gap(18.h),
              Text(
                'Email: andrewwilliams@gmail.com',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        Gap(8.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.w, color: const Color(0xFF333333)),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Vehicle Details:',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              Gap(20.h),
              Text(
                'Car Model: Toyota Corolla',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Gap(18.h),
              Text(
                'Car Plate Number: ABC 123 XY',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Gap(18.h),
              Text(
                'Car Colour: Yellow',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),

        //

        Gap(8.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.w, color: const Color(0xFF333333)),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'License Information:',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              Gap(20.h),
              Text(
                "Driver's License Number:NGR-ABC-12345-XYZ",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Gap(18.h),
              Text(
                'Expiration Date: 31/12/2024',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),

        //

        Gap(8.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.w, color: const Color(0xFF333333)),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Recent Reviews:',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              Gap(20.h),
              Text(
                "Passenger: Lucy John Johnson ",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Gap(18.h),
              Text(
                'Rating: 4.5/5',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Gap(18.h),
              Text(
                'Comment: No Comments',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

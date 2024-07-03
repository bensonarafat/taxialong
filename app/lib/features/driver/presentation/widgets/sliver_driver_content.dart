import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:taxialong/core/constants/assets.dart';
import 'package:taxialong/core/domain/entities/settings_entity.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/core/widgets/taxi_along_cache_network_image.dart';
import 'package:taxialong/features/driver/presentation/widgets/current_location_bustop.dart';
import 'package:taxialong/features/driver/presentation/widgets/sort_class_bottom_sheet.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class SliverDriverContent extends StatelessWidget {
  final VoidCallback callback;
  final String? avatar;
  final String username;
  final SettingsEntity? settings;
  final int online;
  const SliverDriverContent({
    super.key,
    required this.callback,
    required this.avatar,
    required this.online,
    required this.username,
    required this.settings,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
              TaxiAlongCachedNetworkImage(
                url: avatar,
                width: 50.w,
                height: 50.h,
                fit: BoxFit.fill,
              ),
              Gap(12.w),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hi $username',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Gap(2.h),
                  CurrentLocationBustop(online: online),
                ],
              ),
            ],
          ),
          GestureDetector(
            onTap: () async {
              await WoltModalSheet.show<void>(
                enableDrag: true,
                context: context,
                pageListBuilder: (modalSheetContext) {
                  return [
                    sortClassBottomSheet(
                      context: modalSheetContext,
                      settings: settings,
                    ),
                  ];
                },
                modalTypeBuilder: (context) {
                  return WoltModalType.bottomSheet;
                },
                maxDialogWidth: 560.w,
                minDialogWidth: 400.w,
                minPageHeight: 0.0,
              );
              //update the user data
              callback.call();
            },
            child: Container(
              height: 40.h,
              padding: EdgeInsets.all(8.r),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: const Color(0x19DADADA),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    rideSettings,
                    width: 24.w,
                    height: 24.h,
                    colorFilter: ColorFilter.mode(
                      Brightness.dark == Theme.of(context).brightness
                          ? white
                          : dark,
                      BlendMode.dstIn,
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

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:taxialong/core/constants/assets.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/core/widgets/taxi_along_route.dart';
import 'package:taxialong/features/taxi_classes/presentation/widgets/sort_bottom_sheet.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class TaxiClassFlexibleSpace extends StatelessWidget {
  const TaxiClassFlexibleSpace({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints box) {
        final opacity = getCollapseOpacity(context);
        return Stack(
          children: [
            Opacity(
              opacity: opacity,
              child: Container(
                margin: EdgeInsets.only(
                  top: 60.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const TaxiAlongRoute(),
                    Container(
                      alignment: Alignment.topRight,
                      width: 40.w,
                      height: 40.h,
                      margin: EdgeInsets.only(right: 16.w, top: 16.h),
                      padding:
                          EdgeInsets.symmetric(horizontal: 4.h, vertical: 3.w),
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? const Color(0x19DADADA)
                            : const Color.fromARGB(24, 93, 92, 92),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          WoltModalSheet.show<void>(
                            enableDrag: true,
                            context: context,
                            pageListBuilder: (modalSheetContext) {
                              return [
                                sortBottomSheet(modalSheetContext),
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
                        child: Center(
                          child: SvgPicture.asset(
                            sortSVG,
                            colorFilter: ColorFilter.mode(
                              Theme.of(context).brightness == Brightness.dark
                                  ? white
                                  : dark,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

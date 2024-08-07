import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxialong/core/constants/assets.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/features/driver/presentation/bloc/online/online_bloc.dart';

class DriverFlexibleSpace extends StatefulWidget {
  final ValueChanged<bool> onChange;
  final int online;
  const DriverFlexibleSpace({
    super.key,
    required this.onChange,
    required this.online,
  });

  @override
  State<DriverFlexibleSpace> createState() => _DriverFlexibleSpaceState();
}

class _DriverFlexibleSpaceState extends State<DriverFlexibleSpace> {
  bool selected = false;

  @override
  void initState() {
    setSelected();
    super.initState();
  }

  setSelected() {
    setState(() {
      selected = widget.online == 1 ? true : false;
    });
  }

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
                margin: EdgeInsets.only(top: 60.h),
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                      child: Container(
                        width: 24.w,
                        height: 24.h,
                        padding: EdgeInsets.only(top: 2.h, bottom: 1.38.w),
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(),
                        child: SvgPicture.asset(
                          menu,
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).brightness == Brightness.dark
                                ? white
                                : dark,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                    Gap(278.w),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              context.read<OnlineBloc>().add(GoOnlineEvent());
                              setState(() {
                                selected = !selected;
                              });
                              widget.onChange(selected);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 2.w,
                                vertical: 10.h,
                              ),
                              clipBehavior: Clip.antiAlias,
                              decoration: const BoxDecoration(),
                              child: selected
                                  ? SvgPicture.asset(
                                      toggleOn,
                                      width: 36.67.w,
                                      height: 20.h,
                                    )
                                  : SvgPicture.asset(
                                      toggleOff,
                                      width: 36.67.w,
                                      height: 20.h,
                                    ),
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.circle,
                                size: 8,
                                color: selected
                                    ? const Color(0xff18C161)
                                    : const Color(0xffA0A2A9),
                              ),
                              Gap(4.w),
                              Expanded(
                                child: SizedBox(
                                  child: Text(
                                    selected ? 'Online' : 'Offline',
                                    style: GoogleFonts.robotoFlex(
                                      color: const Color(0xFFA0A2A9),
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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

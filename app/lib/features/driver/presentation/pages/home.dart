import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxialong/core/constants/assets.dart';
import 'package:taxialong/core/constants/constants.dart';
import 'package:taxialong/core/data/models/user_model.dart';
import 'package:taxialong/core/services/get_it_services.dart';
import 'package:taxialong/core/services/secure_storage.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/core/widgets/taxi_along_cache_network_image.dart';
import 'package:taxialong/core/widgets/taxi_along_drawer.dart';
import 'package:taxialong/features/driver/presentation/bloc/driver_home_bloc.dart';
import 'package:taxialong/features/driver/presentation/widgets/current_location_bustop.dart';
import 'package:taxialong/features/driver/presentation/widgets/driver_details_widget.dart';
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
  SecureStorage secureStorage = SecureStorage();
  String username = "";
  String avatar = imageplaceholder;
  @override
  void initState() {
    _getUserData();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showEnableLocation(context);
    });

    super.initState();
  }

  void toggleOnOff() {
    setState(() {
      status = !status;
    });
  }

  _getUserData() async {
    UserModel? usermodel = await secureStorage.getUserData();
    setState(() {
      username = "${usermodel?.firstname} ${usermodel?.lastname}";
      avatar = "${usermodel?.avatar}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DriverHomeBloc>(
      create: (context) => getIt<DriverHomeBloc>()..add(DriverHomeFetchEvent()),
      child: Scaffold(
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
                          TaxiAlongCachedNetworkImage(
                            path: avatar,
                            width: 50,
                            height: 50,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100.r),
                            ),
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
                              CurrentLocationBustop(status: status),
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
                          width: 40.w,
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
                                  Brightness.dark ==
                                          Theme.of(context).brightness
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
                ),
                Gap(24.h),
                const DriverDetailsWidget(),
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
      ),
    );
  }
}

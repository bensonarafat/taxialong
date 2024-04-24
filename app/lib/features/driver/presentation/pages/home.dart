import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:taxialong/core/bloc/map/map_bloc.dart';
import 'package:taxialong/core/bloc/web_sockets/pusher/pusher_bloc.dart';
import 'package:taxialong/core/constants/assets.dart';
import 'package:taxialong/core/constants/constants.dart';
import 'package:taxialong/core/data/models/user_model.dart';
import 'package:taxialong/core/domain/entities/settings_entity.dart';
import 'package:taxialong/core/services/get_it_services.dart';
import 'package:taxialong/core/services/secure_storage.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/core/widgets/taxi_along_cache_network_image.dart';
import 'package:taxialong/core/widgets/taxi_along_drawer.dart';
import 'package:taxialong/features/driver/presentation/bloc/home/driver_home_bloc.dart';
import 'package:taxialong/features/driver/presentation/widgets/current_location_bustop.dart';
import 'package:taxialong/features/driver/presentation/widgets/driver_details_widget.dart';
import 'package:taxialong/features/driver/presentation/widgets/driver_flexible_space.dart';
import 'package:taxialong/features/driver/presentation/widgets/driver_map.dart';
import 'package:taxialong/features/driver/presentation/widgets/requests.dart';
import 'package:taxialong/features/driver/presentation/widgets/recents.dart';
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
  String? userId;
  String avatar = imageplaceholder;
  SettingsEntity? settings;
  @override
  void initState() {
    _getUserData();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // NOTE:: Rework on show enable location dialog
      showEnableLocation(context);
      // map bloc event
      context.read<MapBloc>().add(MapCurrentPositionEvent());
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
      userId = usermodel?.id.toString();
      settings = usermodel?.settings;
      status = usermodel?.driver?.online == "1" ? true : false;
    });
    registerTripChannel();
  }

  registerTripChannel() {
    if (userId != null) {
      context.read<PusherBloc>().add(SubscribeToTripChannel(driverId: userId!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DriverHomeBloc>(
      create: (context) => getIt<DriverHomeBloc>()
        ..add(DriverHomeFetchEvent())
        ..add(DriverHomeFetchRecents(loading: true))
        ..add(DriverHomeFetchRequests(loading: true)),
      child: Scaffold(
        drawer: const Drawer(
          child: TaxiAlongDrawer(),
        ),
        body: BlocListener<PusherBloc, PusherState>(
          listener: (context, state) {
            if (state is PusherTripUpdateState) {
              context.read<DriverHomeBloc>()
                ..add(DriverHomeFetchRecents(loading: false))
                ..add(DriverHomeFetchRequests(loading: false));
            }
          },
          child: BlocListener<MapBloc, MapState>(
            listener: (context, state) {
              /// update driver location here
              if (state is MapCurrentPositionState) {
                ///add event here
                context.read<DriverHomeBloc>().add(
                      DriverHomeUpdateLocationEvent(
                        latitude: state.latitude,
                        longitude: state.longitude,
                      ),
                    );
              }
            },
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  shadowColor: Theme.of(context).shadowColor,
                  surfaceTintColor: Theme.of(context).colorScheme.background,
                  backgroundColor: Theme.of(context).colorScheme.background,
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  pinned: false,
                  floating: true,
                  expandedHeight: 100,
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
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    Gap(2.h),
                                    CurrentLocationBustop(status: status),
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
                                _getUserData();
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
                      status ? const Requests() : const Recents(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

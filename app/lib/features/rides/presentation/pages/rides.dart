import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:taxialong/core/bloc/settings/settings_bloc.dart';
import 'package:taxialong/core/constants/assets.dart';
import 'package:taxialong/core/data/models/user_model.dart';
import 'package:taxialong/core/services/get_it_services.dart';
import 'package:taxialong/core/services/secure_storage.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/core/widgets/taxi_along_error_page.dart';
import 'package:taxialong/core/widgets/taxi_along_loading.dart';
import 'package:taxialong/core/widgets/taxi_along_route.dart';
import 'package:taxialong/features/bus_stops/domain/entities/axis_entity.dart';
import 'package:taxialong/features/home/domain/entities/axis_entity.dart'
    as home;
import 'package:taxialong/features/rides/domain/entities/rides_entity.dart';
import 'package:taxialong/features/rides/presentation/bloc/ride_bloc.dart';
import 'package:taxialong/features/rides/presentation/widgets/class_ride.dart';
import 'package:taxialong/features/rides/presentation/widgets/sort_bottom_sheet.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class Rides extends StatefulWidget {
  final Map<String, dynamic> extra;

  const Rides({
    super.key,
    required this.extra,
  });

  @override
  State<Rides> createState() => _RidesState();
}

class _RidesState extends State<Rides> {
  late AxisEntity busstops;
  late home.AxisEntity terminal;
  SecureStorage secureStorage = SecureStorage();
  String paymentMethod = "cash";
  @override
  void initState() {
    busstops = widget.extra['busstops'];
    terminal = widget.extra['terminal'];
    _getUserData();
    super.initState();
  }

  _getUserData() async {
    UserModel? usermodel = await secureStorage.getUserData();
    setState(() {
      if (usermodel?.settings != null) {
        paymentMethod = usermodel?.settings!.paymentMethod ?? "cash";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RideBloc>(
      create: (context) => getIt<RideBloc>()
        ..add(
          FetchRideEvent(
            pointb: busstops.pointb,
          ),
        ),
      child: BlocListener<SettingsBloc, SettingsState>(
        listener: (context, state) {
          if (state is FilterRideState) {
            context.read<RideBloc>().add(
                  FetchRideEvent(
                    pointb: busstops.pointb,
                    rideClass: state.rideClass,
                    seat: state.seat,
                  ),
                );
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TaxiAlongRoute(
                        pointb: busstops.busStop.name,
                        pointa: terminal.terminala.name,
                      ),
                      Container(
                        alignment: Alignment.topRight,
                        width: 40.w,
                        height: 40.h,
                        margin: EdgeInsets.only(right: 16.w, top: 16.h),
                        padding: EdgeInsets.symmetric(
                            horizontal: 4.h, vertical: 3.w),
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
                              pageListBuilder: (context) {
                                return [
                                  sortBottomSheet(
                                    context: context,
                                    pointb: busstops.pointb,
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
                  Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            width: 1.w, color: const Color(0x7F77787B)),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: SizedBox(
                            child: Text(
                              'Available Rides',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  BlocConsumer<RideBloc, RideState>(
                    buildWhen: (pre, state) {
                      return state is RideErrorState ||
                          state is RideLocationDisableState ||
                          state is RideLoadingState ||
                          state is RideLoadedState;
                    },
                    listener: (context, state) {
                      if (state is RideErrorState) {
                        toast(state.message);
                      } else if (state is RideLocationDisableState) {
                        context.go("/enable-location");
                      }
                    },
                    builder: (context, state) {
                      if (state is RideLoadingState) {
                        return TaxiAlongLoading(
                          color: Brightness.dark == Theme.of(context).brightness
                              ? white
                              : dark,
                        );
                      } else if (state is RideLoadedState) {
                        List<RidesEntity> rideEntity = state.ridesEntity;
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: rideEntity.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return ClassRide(
                              rides: rideEntity[index],
                              paymentMethod: paymentMethod,
                            );
                          },
                        );
                      } else {
                        return const TaxiAlongErrorPage();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

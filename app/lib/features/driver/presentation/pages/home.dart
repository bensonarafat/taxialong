import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:taxialong/core/bloc/map/map_bloc.dart';
import 'package:taxialong/core/bloc/web_sockets/pusher/pusher_bloc.dart';
import 'package:taxialong/core/constants/constants.dart';
import 'package:taxialong/core/data/models/user_model.dart';
import 'package:taxialong/core/domain/entities/settings_entity.dart';
import 'package:taxialong/core/services/get_it_services.dart';
import 'package:taxialong/core/services/secure_storage.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/core/widgets/taxi_along_button.dart';
import 'package:taxialong/core/widgets/taxi_along_drawer.dart';
import 'package:taxialong/core/widgets/taxi_along_error_widget.dart';
import 'package:taxialong/core/widgets/taxi_along_loading.dart';
import 'package:taxialong/features/driver/presentation/bloc/home/driver_home_bloc.dart';
import 'package:taxialong/features/driver/presentation/bloc/location/location_bloc.dart';
import 'package:taxialong/features/driver/presentation/bloc/online/online_bloc.dart';
import 'package:taxialong/features/driver/presentation/bloc/recent/recent_bloc.dart';
import 'package:taxialong/features/driver/presentation/bloc/request/request_bloc.dart';
import 'package:taxialong/features/driver/presentation/widgets/driver_details_widget.dart';
import 'package:taxialong/features/driver/presentation/widgets/driver_flexible_space.dart';
import 'package:taxialong/features/driver/presentation/widgets/driver_map.dart';
import 'package:taxialong/features/driver/presentation/widgets/requests.dart';
import 'package:taxialong/features/driver/presentation/widgets/recents.dart';
import 'package:taxialong/features/driver/presentation/widgets/sliver_driver_content.dart';
import 'package:taxialong/features/vehicle/domain/entities/car_entity.dart';
import 'package:taxialong/features/vehicle/domain/entities/cars_entity.dart';
import 'package:taxialong/features/vehicle/presentation/bloc/car_bloc.dart';

class DriverHome extends StatefulWidget {
  const DriverHome({super.key});

  @override
  State<DriverHome> createState() => _DriverHomeState();
}

class _DriverHomeState extends State<DriverHome> {
  SecureStorage secureStorage = SecureStorage();
  String username = "";
  int online = 0;

  String? userId;
  String avatar = imageplaceholder;
  SettingsEntity? settings;
  @override
  void initState() {
    _getUserData();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      registerTripChannel();
      // NOTE:: Rework on show enable location dialog
      showEnableLocation(context);
      // map bloc event
      context.read<MapBloc>().add(MapCurrentPositionEvent());
      context.read<CarBloc>().add(FetchVehiclesEvent());
      showVehicleDialog();
    });

    super.initState();
  }

  _getUserData() async {
    UserModel? usermodel = await secureStorage.getUserData();
    setState(() {
      username = "${usermodel?.firstname} ${usermodel?.lastname}";
      avatar = "${usermodel?.avatar}";
      userId = usermodel?.id.toString();
      settings = usermodel?.settings;

      online = usermodel?.driver?.online ?? 0;
    });
  }

  registerTripChannel() {
    if (userId != null) {
      context.read<PusherBloc>().add(SubscribeToTripChannel(driverId: userId!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DriverHomeBloc>(
          create: (context) =>
              getIt<DriverHomeBloc>()..add(DriverHomeFetchEvent()),
        ),
        BlocProvider<OnlineBloc>(
          create: (context) => getIt<OnlineBloc>(),
        ),
        BlocProvider<LocationBloc>(
          create: (context) => getIt<LocationBloc>(),
        ),
        BlocProvider<RequestBloc>(
          create: (context) =>
              getIt<RequestBloc>()..add(DriverHomeFetchRequests(loading: true)),
        ),
        BlocProvider<RecentBloc>(
          create: (context) =>
              getIt<RecentBloc>()..add(DriverHomeFetchRecents(loading: true)),
        ),
      ],
      child: Scaffold(
        drawer: const Drawer(
          child: TaxiAlongDrawer(),
        ),
        body: BlocListener<PusherBloc, PusherState>(
          listener: (context, state) {
            if (state is PusherTripUpdateState) {
              context
                  .read<RequestBloc>()
                  .add(DriverHomeFetchRequests(loading: false));

              context
                  .read<RecentBloc>()
                  .add(DriverHomeFetchRecents(loading: false));
            }
          },
          child: BlocListener<MapBloc, MapState>(
            listener: (context, state) {
              /// update driver location here
              if (state is MapCurrentPositionState) {
                ///add event here
                context.read<LocationBloc>().add(
                      LocationUpdateLocationEvent(
                        latitude: state.latitude,
                        longitude: state.longitude,
                      ),
                    );
              }
            },
            child: BlocListener<OnlineBloc, OnlineState>(
              listenWhen: (pre, state) => state is OnlineError,
              listener: (context, state) {
                if (state is OnlineError) {
                  toast(state.message);
                }
              },
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    shadowColor: Theme.of(context).shadowColor,
                    surfaceTintColor: Theme.of(context).colorScheme.surface,
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    elevation: 0,
                    automaticallyImplyLeading: false,
                    pinned: false,
                    floating: true,
                    expandedHeight: 100,
                    forceElevated: true,
                    flexibleSpace: FutureBuilder<UserModel?>(
                        future: secureStorage.getUserData(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return DriverFlexibleSpace(
                              online: online,
                              onChange: (bool selected) {
                                setState(() {
                                  online = selected ? 1 : 0;
                                });
                              },
                            );
                          } else {
                            return const TaxiAlongLoading();
                          }
                        }),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        SliverDriverContent(
                          callback: () {
                            _getUserData();
                          },
                          avatar: avatar,
                          online: online,
                          username: username,
                          settings: settings,
                        ),
                        Gap(24.h),
                        const DriverDetailsWidget(),
                        Gap(24.h),
                        const DriverMap(),
                        Gap(16.h),
                        online == 1 ? const Requests() : const Recents(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> showVehicleDialog() async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        int? selectedValueId;
        return AlertDialog(
            title: Text(
              "Select vehicle",
              style: Theme.of(context).textTheme.headlineSmall!,
            ),
            content: StatefulBuilder(
                builder: (BuildContext context, StateSetter newState) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(),
                    BlocBuilder<CarBloc, CarState>(
                      builder: (context, state) {
                        if (state is LoadingCarState) {
                          return TaxiAlongLoading(
                            color:
                                Brightness.dark == Theme.of(context).brightness
                                    ? white
                                    : dark,
                          );
                        } else if (state is FetchCarsState) {
                          CarsEntity carsEntity = state.carsEntity;
                          if (carsEntity.status) {
                            List<CarEntity>? cars = carsEntity.cars;
                            if (cars == null) {
                              return createNewCarButton(context);
                            } else if (cars.isEmpty) {
                              return createNewCarButton(context);
                            } else {
                              return Column(
                                children: List<Widget>.generate(cars.length,
                                    (int index) {
                                  return RadioListTile<int?>(
                                    controlAffinity:
                                        ListTileControlAffinity.trailing,
                                    activeColor: primaryColor,
                                    title: Text(
                                      cars[index].plateNumber,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            fontSize: 16.sp,
                                          ),
                                    ),
                                    groupValue: selectedValueId,
                                    value: cars[index].id,
                                    onChanged: (int? value) {
                                      newState(() => selectedValueId = value);
                                    },
                                  );
                                }),
                              );
                            }
                          } else {
                            return const TaxiAlongErrorWidget();
                          }
                        } else {
                          return const TaxiAlongErrorWidget();
                        }
                      },
                    ),
                    TaxiAlongButton(
                        onPressed: () {
                          if (selectedValueId != null) {
                            Navigator.pop(context);
                            context.read<CarBloc>().add(
                                UpdateDefaultCarEvent(id: selectedValueId!));
                          } else {
                            toast("You need to select a Car to continue");
                          }
                        },
                        buttonText: "Select Car"),
                  ],
                ),
              );
            }));
      },
    );
  }

  Widget createNewCarButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor),
        borderRadius: BorderRadius.circular(8.w),
      ),
      margin: EdgeInsets.only(top: 8.h, bottom: 8.h),
      child: Center(
          child: TextButton.icon(
        onPressed: () async {
          await context.push("/create-vehicle");
          // ignore: use_build_context_synchronously
          context.read<CarBloc>().add(FetchVehiclesEvent());
        },
        icon: const Icon(Icons.add),
        label: Text(
          "Create new car",
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontSize: 15.sp,
              ),
        ),
      )),
    );
  }
}

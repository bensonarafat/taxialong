import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxialong/core/bloc/bottom_navigation/bottom_navigation_bloc.dart';
import 'package:taxialong/core/bloc/bottom_navigation/bottom_navigation_event.dart';
import 'package:taxialong/core/bloc/bottom_navigation/bottom_navigation_state.dart';
import 'package:taxialong/core/bloc/map/map_bloc.dart';
import 'package:taxialong/core/constants/assets.dart';
import 'package:taxialong/core/services/get_it_services.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/core/widgets/taxi_along_drawer.dart';
import 'package:taxialong/features/home/presentation/bloc/home/home_bloc.dart';
import 'package:taxialong/features/home/presentation/pages/home.dart';
import 'package:taxialong/features/wallet/presentation/pages/wallet.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

List<BottomNavigationBarItem> bottomNavItems = <BottomNavigationBarItem>[
  BottomNavigationBarItem(
    icon: Image.asset(
      homeInactiveIcon,
      width: 20.w,
      height: 16.h,
    ),
    label: 'Home',
    activeIcon: Image.asset(
      homeActiveIcon,
      width: 20.w,
      height: 16.h,
    ),
  ),
  // BottomNavigationBarItem(
  //   icon: Image.asset(
  //     recentStopInactiveIcon,
  //     width: 20.w,
  //     height: 16.h,
  //   ),
  //   label: 'Recent Stops',
  //   activeIcon: Image.asset(
  //     recentStopActiveIcon,
  //     width: 20.w,
  //     height: 16.h,
  //   ),
  // ),
  BottomNavigationBarItem(
    icon: Image.asset(
      walletInactiveIcon,
      width: 20.w,
      height: 16.h,
    ),
    label: 'Wallet',
    activeIcon: Image.asset(
      walletActiveIcon,
      width: 20.w,
      height: 16.h,
    ),
  ),
];

const List<Widget> bottomNavScreen = <Widget>[
  Home(),
  // RecentStops(),
  Wallet(),
];

class TaxiAlongBottomNavigation extends StatefulWidget {
  const TaxiAlongBottomNavigation({super.key});

  @override
  State<TaxiAlongBottomNavigation> createState() =>
      _TaxiAlongBottomNavigationState();
}

class _TaxiAlongBottomNavigationState extends State<TaxiAlongBottomNavigation> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showEnableLocation(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (BuildContext context) => getIt<HomeBloc>(),
        ),
      ],
      child: BlocListener<MapBloc, MapState>(
        listener: (context, state) {
          if (state is MapCurrentPositionState) {
            context.read<HomeBloc>().add(
                  UpdateTerminalEvent(
                    latitude: state.latitude,
                    longitude: state.longitude,
                  ),
                );
          }
        },
        child: BlocConsumer<BottomNavigationBloc, BottomNavigationState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Scaffold(
                body: bottomNavScreen.elementAt(state.index),
                drawer: const Drawer(
                  child: TaxiAlongDrawer(),
                ),
                bottomNavigationBar: BottomNavigationBar(
                  elevation: 1,
                  type: BottomNavigationBarType.fixed,
                  items: bottomNavItems,
                  currentIndex: state.index,
                  selectedItemColor: primaryColor,
                  selectedFontSize: 14.sp,
                  unselectedFontSize: 14.sp,
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  onTap: (index) =>
                      BlocProvider.of<BottomNavigationBloc>(context)
                          .add(TabChange(index: index)),
                ),
              );
            }),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxialong/core/constants/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxialong/core/services/get_it_services.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/core/widgets/taxi_along_loading.dart';
import 'package:taxialong/features/home/presentation/bloc/home/home_bloc.dart';
import 'package:taxialong/features/home/presentation/widgets/home_flexible_space.dart';
import 'package:taxialong/core/widgets/taxi_along_bus_stop.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
          create: (BuildContext context) => getIt<HomeBloc>()
            ..add(FetchHomeTerminals(
              latitude: null,
              longitude: null,
            )),
        ),
      ],
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            scrolledUnderElevation: 0,
            shadowColor: Theme.of(context).shadowColor,
            surfaceTintColor: Theme.of(context).colorScheme.background,
            backgroundColor: Theme.of(context).colorScheme.background,
            elevation: 0,
            automaticallyImplyLeading: false,
            pinned: true,
            floating: true,
            expandedHeight: appSliverExpandedHeightFixture.h,
            forceElevated: true,
            flexibleSpace: const HomeFlexibleSpace(),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state is HomeLoadingState) {
                      return const TaxiAlongLoading();
                    } else if (state is HomeErrorState) {
                      return const Text("Error");
                    } else if (state is HomeLoadedState) {
                      return Container(
                        padding: EdgeInsets.all(
                          16.w,
                        ),
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: busstops.length,
                          itemBuilder: (_, index) {
                            return TaxiAlongBusStops(
                              busstops: busstops,
                              index: index,
                              type: "home",
                            );
                          },
                        ),
                      );
                    } else {
                      return const Text("Error");
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

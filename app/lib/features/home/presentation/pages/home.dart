import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxialong/core/constants/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/core/widgets/taxi_along_error_page.dart';
import 'package:taxialong/core/widgets/taxi_along_loading.dart';
import 'package:taxialong/features/home/domain/entities/axis_entity.dart';
import 'package:taxialong/features/home/presentation/bloc/home/home_bloc.dart';
import 'package:taxialong/features/home/presentation/widgets/home_bus_stops.dart';
import 'package:taxialong/features/home/presentation/widgets/home_flexible_space.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<HomeBloc>().add(
            UpdateTerminalEvent(
              latitude: defaultLat,
              longitude: defaultLng,
            ),
          );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          scrolledUnderElevation: 0,
          shadowColor: Theme.of(context).shadowColor,
          surfaceTintColor: Theme.of(context).colorScheme.surface,
          backgroundColor: Theme.of(context).colorScheme.surface,
          elevation: 0,
          automaticallyImplyLeading: false,
          pinned: true,
          floating: true,
          expandedHeight: appSliverExpandedHeightFixture,
          forceElevated: true,
          flexibleSpace: const HomeFlexibleSpace(),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              BlocConsumer<HomeBloc, HomeState>(
                listener: (context, state) {
                  if (state is HomeErrorState) {
                    toast(state.message);
                  }
                },
                builder: (context, state) {
                  if (state is HomeLoadingState) {
                    return TaxiAlongLoading(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? white
                          : dark,
                    );
                  } else if (state is HomeErrorState) {
                    return const TaxiAlongErrorPage();
                  } else if (state is HomeLoadedState) {
                    List<AxisEntity> terminals = state.axisEntity;
                    return Container(
                      padding: EdgeInsets.all(
                        16.w,
                      ),
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: terminals.length,
                        itemBuilder: (_, index) {
                          return HomeTerminals(
                            terminals: terminals,
                            index: index,
                          );
                        },
                      ),
                    );
                  } else {
                    return const TaxiAlongErrorPage();
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

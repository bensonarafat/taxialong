import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxialong/core/services/get_it_services.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/core/widgets/taxi_along_error_page.dart';
import 'package:taxialong/core/widgets/taxi_along_loading.dart';
import 'package:taxialong/features/bus_stops/domain/entities/axis_entity.dart'
    as busstop;
import 'package:taxialong/features/bus_stops/presentation/widgets/bus_stop_name.dart';
import 'package:taxialong/features/bus_stops/presentation/bloc/busstop/bus_stop_bloc.dart';
import 'package:taxialong/features/bus_stops/presentation/widgets/bus_stops_flexible_space.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxialong/features/home/domain/entities/axis_entity.dart'
    as home;

class BusStop extends StatefulWidget {
  final Map<String, dynamic> params;
  const BusStop({super.key, required this.params});

  @override
  State<BusStop> createState() => _BusStopState();
}

class _BusStopState extends State<BusStop> {
  late List<home.AxisEntity> terminals;
  late int index;
  late String axis;
  int selected = 0;

  @override
  void initState() {
    super.initState();
    terminals = widget.params['terminals'];
    index = widget.params['index'];
    axis =
        "${terminals[index].terminala.name} along ${terminals[index].terminalb.name}";
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> key = GlobalKey();

    return BlocProvider<BusStopBloc>(
      create: (context) => getIt<BusStopBloc>()
        ..add(
          BusStopFetchEvent(
            pointa: terminals[index].pointa,
            pointb: terminals[index].pointb,
          ),
        ),
      child: Scaffold(
        key: key,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              scrolledUnderElevation: 0,
              shadowColor: Theme.of(context).shadowColor,
              surfaceTintColor: Theme.of(context).colorScheme.surface,
              backgroundColor: Theme.of(context).colorScheme.surface,
              automaticallyImplyLeading: false,
              pinned: true,
              expandedHeight: 74,
              forceElevated: true,
              flexibleSpace: BusStopsFlexibleSpace(axis: axis),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    padding: EdgeInsets.all(16.w),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (int index = 0; index < terminals.length; index++)
                            Builder(builder: (context) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selected = index;
                                    axis =
                                        "${terminals[selected].terminala.name} along ${terminals[selected].terminalb.name}";
                                  });
                                  context.read<BusStopBloc>().add(
                                        BusStopFetchEvent(
                                          pointa: terminals[selected].pointa,
                                          pointb: terminals[selected].pointb,
                                        ),
                                      );
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                    right: 16.w,
                                  ),
                                  padding: EdgeInsets.all(8.w),
                                  decoration: ShapeDecoration(
                                    color: index == selected
                                        ? primaryColor
                                        : Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? const Color.fromARGB(
                                                24, 101, 100, 100)
                                            : const Color.fromRGBO(
                                                218, 218, 218, 0.10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "${terminals[index].terminala.name} along ${terminals[index].terminalb.name}",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            fontSize: 16.sp,
                                            color: index == selected
                                                ? white
                                                : Theme.of(context)
                                                            .brightness ==
                                                        Brightness.dark
                                                    ? white
                                                    : dark,
                                          ),
                                    ),
                                  ),
                                ),
                              );
                            })
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.w),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide.none,
                        top: BorderSide(
                          width: 1.w,
                          color: const Color(0xffCECECE),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: SizedBox(
                            child: Text(
                              '$axis axis',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(fontSize: 20.sp),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  BlocConsumer<BusStopBloc, BusStopState>(
                    listener: (context, state) {
                      if (state is BusStopErrorState) {
                        toast(state.message);
                      }
                    },
                    builder: (context, state) {
                      if (state is BusStopLoadingState) {
                        return TaxiAlongLoading(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? white
                              : dark,
                        );
                      } else if (state is BusStopErrorState) {
                        return const TaxiAlongErrorPage();
                      } else if (state is BusStopLoadedState) {
                        List<busstop.AxisEntity> busstops = state.busstops;
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
                              return BusStopsName(
                                busstops: busstops[index],
                                index: index,
                                terminal: terminals[selected],
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
        ),
      ),
    );
  }
}

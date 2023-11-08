import 'package:flutter/material.dart';
import 'package:taxialong/core/constants/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxialong/core/utils/helpers.dart';
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
    return CustomScrollView(
      slivers: [
        SliverAppBar(
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
              Container(
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
              ),
            ],
          ),
        ),
      ],
    );
  }
}

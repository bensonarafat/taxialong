import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/core/widgets/taxi_along_error_widget.dart';
import 'package:taxialong/core/widgets/taxi_along_loading.dart';
import 'package:taxialong/core/widgets/taxi_along_route.dart';
import 'package:taxialong/features/driver/domain/entities/trip_entity.dart';
import 'package:taxialong/features/driver/presentation/bloc/home/driver_home_bloc.dart';
import 'package:taxialong/features/driver/presentation/widgets/ride_widget.dart';

class Requests extends StatelessWidget {
  const Requests({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TaxiAlongRoute(
          pointa: "Apo junction",
          pointb: "Lungbe Juctions",
        ),
        Gap(16.h),
        Container(
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
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
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
        ),
        BlocBuilder<DriverHomeBloc, DriverHomeState>(
          builder: (context, state) {
            if (state is RequestRecentLoading) {
              return TaxiAlongLoading(
                color: Theme.of(context).brightness == Brightness.dark
                    ? white
                    : dark,
              );
            } else if (state is RequestRecentLoaded) {
              List<TripEntity> trips = state.tripEntity;
              return Column(
                children: [
                  for (int i = 0; i < trips.length; i++)
                    RideWidget(trip: trips[i]),
                ],
              );
            } else {
              return const TaxiAlongErrorWidget();
            }
          },
        ),
      ],
    );
  }
}

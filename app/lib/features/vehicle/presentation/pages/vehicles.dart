import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/core/widgets/taxi_along_button.dart';
import 'package:taxialong/core/widgets/taxi_along_error_widget.dart';
import 'package:taxialong/core/widgets/taxi_along_loading.dart';
import 'package:taxialong/features/vehicle/domain/entities/car_entity.dart';
import 'package:taxialong/features/vehicle/domain/entities/cars_entity.dart';
import 'package:taxialong/features/vehicle/presentation/bloc/car_bloc.dart';
import 'package:taxialong/features/vehicle/presentation/widgets/vehicle_list.dart';

import '../../../../core/services/get_it_services.dart';

class Vehicles extends StatefulWidget {
  const Vehicles({super.key});

  @override
  State<Vehicles> createState() => _VehiclesState();
}

class _VehiclesState extends State<Vehicles> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CarBloc>(
      create: (context) => getIt<CarBloc>()..add(FetchVehiclesEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'My Vehicles',
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: IconTheme(
              data: Theme.of(context).iconTheme,
              child: const Icon(
                Icons.keyboard_arrow_left,
              ),
            ),
          ),
        ),
        body: BlocConsumer<CarBloc, CarState>(
          listener: (context, state) {
            if (state is ErrorCarState) {
              toast(state.message);
            }
          },
          buildWhen: (prev, state) {
            return state is LoadingCarState ||
                state is FetchCarsState ||
                state is ErrorCarState;
          },
          builder: (context, state) {
            if (state is LoadingCarState) {
              return TaxiAlongLoading(
                color: Brightness.dark == Theme.of(context).brightness
                    ? white
                    : dark,
              );
            } else if (state is FetchCarsState) {
              CarsEntity carsEntity = state.carsEntity;
              List<CarEntity>? cars = carsEntity.cars;
              if (cars != null) {
                if (cars.isNotEmpty) {
                  return VehicleList(cars: cars);
                } else {
                  return navigateToCreateCar(context);
                }
              } else {
                return const TaxiAlongErrorWidget();
              }
            } else {
              return const TaxiAlongErrorWidget();
            }
          },
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TaxiAlongButton(
            buttonText: "Add Vehicle",
            onPressed: () {
              context.replace("/create-vehicle");
            },
          ),
        ),
      ),
    );
  }

  Widget navigateToCreateCar(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Text(
            "No Vehicle Found",
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        Gap(16.h),
        TaxiAlongButton(onPressed: () {}, buttonText: "Create Vehicle"),
      ],
    );
  }
}

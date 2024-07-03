import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:taxialong/core/bloc/settings/settings_bloc.dart';
import 'package:taxialong/core/constants/constants.dart';
import 'package:taxialong/core/domain/entities/seats_entity.dart';
import 'package:taxialong/core/services/get_it_services.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/core/widgets/taxi_along_button.dart';
import 'package:taxialong/core/widgets/taxi_along_drop_down.dart';
import 'package:taxialong/core/widgets/taxi_along_error_widget.dart';
import 'package:taxialong/core/widgets/taxi_along_input_field.dart';
import 'package:taxialong/core/widgets/taxi_along_loading.dart';
import 'package:taxialong/features/vehicle/domain/entities/car_entity.dart';
import 'package:taxialong/features/vehicle/presentation/bloc/car_bloc.dart';
import 'package:taxialong/features/vehicle/presentation/widgets/vehicle_class.dart';

class EditVehicle extends StatefulWidget {
  final CarEntity car;
  const EditVehicle({
    super.key,
    required this.car,
  });

  @override
  State<EditVehicle> createState() => _EditVehicleState();
}

class _EditVehicleState extends State<EditVehicle> {
  late CarEntity car;
  late String model;
  late String plateNumber;
  late String? color;
  int? seatId;
  String? seat;
  bool isDefault = false;
  List<dynamic> classSelected = [];
  List<dynamic> classes = [];
  TextEditingController carModelController = TextEditingController();
  TextEditingController plateNumberController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SettingsBloc>().add(GetSeatsEvent());
    });
    car = widget.car;
    model = car.model;
    seatId = car.seatId;
    carModelController.text = model;
    plateNumber = car.plateNumber;
    plateNumberController.text = plateNumber;
    color = car.color;
    isDefault = car.isDefault == 1 ? true : false;
    classSelected = car.classes ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CarBloc>(
      create: (context) => getIt<CarBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Edit Vehicle',
          ),
          leading: GestureDetector(
            onTap: () {
              context.replace("/vehicles");
            },
            child: IconTheme(
              data: Theme.of(context).iconTheme,
              child: const Icon(
                Icons.keyboard_arrow_left,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              TaxiAlongInputField(
                label: "Car Model",
                hint: "Enter Car Model here e.g: Toyotal Camry",
                controller: carModelController,
                onChange: (input) {
                  setState(() {
                    model = input;
                  });
                },
              ),
              Gap(16.h),
              TaxiAlongInputField(
                label: "Plate Number",
                hint: "Enter Plate Number here e.g: ABC-123DE",
                controller: plateNumberController,
                onChange: (input) {
                  setState(() {
                    plateNumber = input;
                  });
                },
              ),
              Gap(16.h),
              TaxiAlongDropDown(
                value: color,
                items: carColours,
                label: 'Car Colour',
                onChange: (String? input) {
                  setState(() {
                    color = input;
                  });
                },
              ),
              Gap(16.h),
              BlocBuilder<SettingsBloc, SettingsState>(
                buildWhen: (pre, state) =>
                    state is SeatsLoadingState ||
                    state is SeatsLoadedState ||
                    state is SeatsErrorState,
                builder: (context, state) {
                  if (state is SeatsLoadingState) {
                    return TaxiAlongLoading(
                        color: Brightness.dark == Theme.of(context).brightness
                            ? white
                            : dark);
                  } else if (state is SeatsLoadedState) {
                    List<SeatsEntity> seats = state.seats;
                    classes = seats.first.classes ?? [];
                    SeatsEntity currentseat = seats.first;
                    for (SeatsEntity el in seats) {
                      if (el.id == seatId) {
                        currentseat = el;
                        seat = el.name;
                      }
                    }

                    return Column(
                      children: [
                        TaxiAlongDropDown.buildSeatsDropDown(
                          value: currentseat,
                          context: context,
                          items: seats,
                          label: 'Car Seat',
                          onChange: (SeatsEntity? input) {
                            setState(() {
                              seat = input?.name;
                              seatId = input?.id;
                              classes = input?.classes ?? [];
                            });
                          },
                          moreInfo: GestureDetector(
                            onTap: () => context.push("/seats-info"),
                            child: Icon(
                              Icons.info_outline_rounded,
                              size: 17.r,
                            ),
                          ),
                        ),
                        Gap(16.h),
                        // check box with classes
                        VehicleClass(
                          selected: classSelected,
                          classes: classes,
                          callback: (dynamic selected, bool? isCheck) {
                            if (isCheck != null) {
                              if (isCheck) {
                                classSelected.add(selected);
                              } else {
                                classSelected.remove(selected);
                              }
                            }
                          },
                        ),
                      ],
                    );
                  } else {
                    return const TaxiAlongErrorWidget();
                  }
                },
              ),
              Gap(16.h),
              BlocConsumer<CarBloc, CarState>(
                listener: (context, state) {
                  if (state is ErrorCarState) {
                    toast(state.message);
                  }
                  if (state is CreatedCarState) {
                    if (state.carEntity.status) {
                      context.replace("/vehicles");
                    }
                    toast(state.carEntity.message);
                  }
                },
                builder: (context, state) {
                  bool isloading = false;
                  if (state is LoadingCarState) {
                    isloading = true;
                  } else {
                    isloading = false;
                  }

                  return TaxiAlongButton(
                    onPressed: () {
                      if (!isloading) {
                        if (model.isEmpty) {
                          toast("Car Model is required");
                        } else if (plateNumber.isEmpty) {
                          toast("Plate number is required");
                        } else if (color == null) {
                          toast("Colour is required");
                        } else if (seatId == null) {
                          toast("Car Seat is required");
                        } else if (classSelected.isEmpty) {
                          toast("You must select atleast one class");
                        } else {
                          context.read<CarBloc>().add(
                                EditCarEvent(
                                  id: car.id,
                                  model: model,
                                  plateNumber: plateNumber,
                                  color: color!,
                                  seatId: seatId!,
                                  classes: classSelected,
                                ),
                              );
                        }
                      }
                    },
                    buttonText: "Update Car",
                    loading: isloading,
                  );
                },
              ),
              Gap(16.h),
              BlocConsumer<CarBloc, CarState>(
                listener: (context, state) {
                  if (state is ErrorCarState) {
                    toast(state.message);
                  }
                },
                builder: (context, state) {
                  bool isloading = false;
                  if (state is LoadingCarState) {
                    isloading = true;
                  } else {
                    isloading = false;
                  }
                  return TaxiAlongButton(
                    loading: isloading,
                    onPressed: () => context.read<CarBloc>().add(
                          DeleteVehicleEvent(id: car.id),
                        ),
                    buttonText: 'Delete',
                    color: Colors.red,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

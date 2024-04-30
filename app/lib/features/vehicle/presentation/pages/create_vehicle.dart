import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:taxialong/core/constants/assets.dart';
import 'package:taxialong/core/constants/constants.dart';
import 'package:taxialong/core/services/get_it_services.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/core/widgets/taxi_along_button.dart';
import 'package:taxialong/core/widgets/taxi_along_drop_down.dart';
import 'package:taxialong/core/widgets/taxi_along_input_field.dart';
import 'package:taxialong/features/vehicle/presentation/bloc/car_bloc.dart';

class CreateVehicle extends StatefulWidget {
  const CreateVehicle({super.key});

  @override
  State<CreateVehicle> createState() => _CreateVehicleState();
}

class _CreateVehicleState extends State<CreateVehicle> {
  String model = "";
  String plateNumber = "";
  String? color = carColours.first;
  String? seat = seatsArrangments.first;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CarBloc>(
      create: (context) => getIt<CarBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Create Vehicle',
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              TaxiAlongInputField(
                label: "Car Model",
                hint: "Enter Car Model here e.g: Toyotal Camry",
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
                onChange: (input) {
                  setState(() {
                    plateNumber = input;
                  });
                },
              ),
              Gap(16.h),
              TaxiAlongDropDown(
                items: carColours,
                label: 'Car Colour',
                onChange: (String? input) {
                  setState(() {
                    color = input;
                  });
                },
              ),
              Gap(16.h),
              TaxiAlongDropDown(
                items: seatsArrangments,
                label: 'Car Seat',
                onChange: (String? input) {
                  setState(() {
                    seat = input;
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
              BlocConsumer<CarBloc, CarState>(
                listener: (context, state) {
                  if (state is ErrorCarState) {
                    toast(state.message);
                  }
                  if (state is CreatedCarState) {
                    if (state.carEntity.status) {
                      documentAlert(context).show();
                    } else {
                      toast(state.carEntity.message);
                    }
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
                        } else if (seat == null) {
                          toast("Seat Arrangment is required");
                        } else {
                          context.read<CarBloc>().add(
                                CreateCarEvent(
                                  model: model,
                                  plateNumber: plateNumber,
                                  color: color!,
                                  seats: seat!,
                                ),
                              );
                        }
                      }
                    },
                    buttonText: "Create New Car",
                    loading: isloading,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Alert documentAlert(BuildContext context) {
    return Alert(
        style: AlertStyle(
          alertBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
            side: const BorderSide(
              color: Color(0xFF121212),
            ),
          ),
          isCloseButton: false,
          titleStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.w500,
              ),
          descStyle: Theme.of(context).textTheme.titleSmall!,
        ),
        context: context,
        desc:
            "You have successfully registered as a Taxi Along Driver. You now have a Driver Account. Your details have been received and are being reviewed. Your information has been received and is being examined. You would be informed of the review status within the next 2 working days..",
        image: SvgPicture.asset(
          documentsCheck,
          width: 208.w,
          height: 208.h,
        ),
        buttons: [
          DialogButton(
            color: Colors.transparent,
            onPressed: () {
              Navigator.of(context).pop();
              context.push("/create-vehicle");
            },
            child: Container(
              width: 254.w,
              height: 42.h,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
              decoration: ShapeDecoration(
                color: primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Done',
                    style: GoogleFonts.robotoFlex(
                      color: white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          )
        ]);
  }
}

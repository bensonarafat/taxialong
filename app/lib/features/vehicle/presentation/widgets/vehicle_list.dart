import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/features/vehicle/domain/entities/car_entity.dart';
import 'package:taxialong/features/vehicle/presentation/bloc/car_bloc.dart';

class VehicleList extends StatefulWidget {
  const VehicleList({
    super.key,
    required this.cars,
  });

  final List<CarEntity>? cars;

  @override
  State<VehicleList> createState() => _VehicleListState();
}

class _VehicleListState extends State<VehicleList> {
  List<CarEntity> cars = [];
  int? selectedValueId;
  @override
  void initState() {
    cars = widget.cars ?? [];
    selectedValueId = cars.first.id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return RadioListTile<int>(
          secondary: IconButton(
            icon: const Icon(Icons.edit_document),
            onPressed: () async {
              await context.push("/edit-vehicle", extra: cars[index]);
              // ignore: use_build_context_synchronously
              context.read<CarBloc>().add(FetchVehiclesEvent());
            },
          ),
          controlAffinity: ListTileControlAffinity.trailing,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          activeColor: primaryColor,
          title: Text(
            cars[index].plateNumber,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontSize: 24.sp,
                ),
          ),
          subtitle: Row(
            children: [
              Text(
                cars[index].model,
                style: Theme.of(context).textTheme.labelSmall,
              ),
              Gap(8.w),
              selectedValueId == cars[index].id
                  ? Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(20.w),
                      ),
                      child: Text(
                        "Default",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: white,
                              fontSize: 8.sp,
                            ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
          value: cars[index].id,
          groupValue: selectedValueId,
          onChanged: (int? value) {
            setState(() {
              selectedValueId = value!;
              context
                  .read<CarBloc>()
                  .add(UpdateDefaultCarEvent(id: cars[index].id));
            });
          },
        );
      },
      separatorBuilder: (context, index) => const Divider(),
      itemCount: cars.length,
    );
  }
}

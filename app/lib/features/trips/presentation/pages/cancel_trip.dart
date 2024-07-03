import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxialong/core/services/get_it_services.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/core/widgets/taxi_along_loading.dart';
import 'package:taxialong/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:taxialong/features/trips/domain/entities/trip_entity.dart';
import 'package:taxialong/features/trips/domain/entities/cancel_entity.dart';
import 'package:taxialong/features/trips/presentation/bloc/cancel_trip/cancel_bloc.dart';

class CancelTrip extends StatelessWidget {
  final TripEntity trip;
  const CancelTrip({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    TextEditingController reasonController = TextEditingController();
    return BlocProvider<CancelBloc>(
      create: (context) => getIt<CancelBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Cancel Trip',
          ),
          leading: GestureDetector(
            onTap: () {
              context.pop();
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
          child: Container(
            padding: EdgeInsets.all(16.h),
            child: Column(
              children: [
                TextField(
                  controller: reasonController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    labelText: 'Reason for canceling this ride',
                    border: OutlineInputBorder(),
                  ),
                ),
                Gap(16.h),
                BlocConsumer<CancelBloc, CancelState>(
                  listener: (context, state) {
                    if (state is CancelErrorState) {
                      toast(state.message);
                    }
                    if (state is TripCancelState) {
                      CancelEntity cancelEntity = state.cancelEntity;
                      toast(cancelEntity.message);
                      if (cancelEntity.status) {
                        context.read<AuthBloc>().add(CheckAuth());
                        context.go("/nav");
                      }
                    }
                  },
                  builder: (context, state) {
                    return GestureDetector(
                      onTap: () {
                        if (reasonController.text != "") {
                          context.read<CancelBloc>().add(CancelTripEvent(
                                tripId: trip.id.toString(),
                                reason: reasonController.text,
                              ));
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50.h,
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
                            state is CancelLoadingState
                                ? const TaxiAlongLoading()
                                : Text(
                                    'Cancel Ride',
                                    style: GoogleFonts.robotoFlex(
                                      color: white,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

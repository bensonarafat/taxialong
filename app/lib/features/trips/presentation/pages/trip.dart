import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:taxialong/core/bloc/map/map_bloc.dart';
import 'package:taxialong/core/bloc/web_sockets/pusher/pusher_bloc.dart';
import 'package:taxialong/core/services/get_it_services.dart';
import 'package:taxialong/features/rides/domain/entities/confirm_ride_entity.dart';
import 'package:taxialong/features/trips/domain/entities/update_trip_entity.dart';
import 'package:taxialong/features/trips/presentation/bloc/trip_bloc.dart';
import 'package:taxialong/features/trips/presentation/widgets/bottom_sheet_view_content.dart';

import 'package:taxialong/features/trips/presentation/widgets/taxi_along_google_map.dart';

class Trip extends StatefulWidget {
  final ConfirmRideEntity confirmRideEntity;
  const Trip({
    super.key,
    required this.confirmRideEntity,
  });

  @override
  State<Trip> createState() => _TripState();
}

class _TripState extends State<Trip> {
  @override
  void initState() {
    context.read<PusherBloc>().add(
          SubscribeToDriverChannel(
            driverId: widget.confirmRideEntity.trip!.driverId.toString(),
          ),
        );
    super.initState();
  }

  var dragController = DraggableScrollableController();

  @override
  void dispose() {
    dragController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TripBloc>(
      create: (context) => getIt<TripBloc>(),
      child: Scaffold(
        body: BlocListener<TripBloc, TripState>(
          listener: (context, state) {
            if (state is UpdateCompleteState) {
              UpdateTripEntity updateTripEntity = state.updateTripEntity;
              if (updateTripEntity.status) {
                context.go(
                  "/rating",
                  extra: widget.confirmRideEntity.trip!,
                );
              }
            }

            if (state is UpdatePickUpState) {
              UpdateTripEntity updateTripEntity = state.updateTripEntity;
              if (updateTripEntity.status) {
                context.read<MapBloc>().add(UpdatePickUpMapEvent());
              }
            }
          },
          child: Stack(
            children: [
              TaxiAlongGoogleMap(
                trip: widget.confirmRideEntity.trip!,
              ),
              DraggableScrollableSheet(
                initialChildSize: 0.4,
                minChildSize: 0.3,
                maxChildSize: 0.8,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return SingleChildScrollView(
                    controller: scrollController,
                    child: BottomSheetViewContent(
                      ridedetails: widget.confirmRideEntity,
                    ),
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:taxialong/core/bloc/map/map_bloc.dart';
import 'package:taxialong/core/bloc/web_sockets/pusher/pusher_bloc.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/core/widgets/taxi_along_error_widget.dart';
import 'package:taxialong/core/widgets/taxi_along_loading.dart';
import 'package:taxialong/features/trips/domain/entities/trip_entity.dart';
import 'package:taxialong/features/trips/domain/entities/update_trip_entity.dart';
import 'package:taxialong/features/trips/presentation/bloc/trip_bloc.dart';
import 'package:taxialong/features/trips/presentation/widgets/bottom_sheet_view_content.dart';

import 'package:taxialong/features/trips/presentation/widgets/taxi_along_google_map.dart';

class Trip extends StatefulWidget {
  const Trip({
    super.key,
  });

  @override
  State<Trip> createState() => _TripState();
}

class _TripState extends State<Trip> {
  @override
  void initState() {
    context.read<TripBloc>().add(GetTripEvent());
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
    return Scaffold(
      body: BlocConsumer<TripBloc, TripState>(
        listenWhen: (pre, state) =>
            state is UpdateCompleteState ||
            state is UpdatePickUpState ||
            state is CurrentTripState,
        listener: (context, state) {
          if (state is UpdateCompleteState) {
            UpdateTripEntity updateTripEntity = state.tripEntity;
            if (updateTripEntity.status) {
              context.go(
                "/rating",
                extra: updateTripEntity.trip,
              );
            }
          }

          if (state is UpdatePickUpState) {
            UpdateTripEntity updateTripEntity = state.updateTripEntity;
            if (updateTripEntity.status) {
              context.read<MapBloc>().add(UpdatePickUpMapEvent());
            }
          }

          if (state is CurrentTripState) {
            TripEntity trip = state.trip;
            context.read<PusherBloc>().add(
                  SubscribeToDriverChannel(
                    driverId: trip.driverId,
                  ),
                );
          }
        },
        buildWhen: (pre, state) {
          return state is TripLoadingState ||
              state is CurrentTripState ||
              state is TripErrorState;
        },
        builder: (context, state) {
          if (state is TripLoadingState) {
            return TaxiAlongLoading(
              color: Brightness.dark == Theme.of(context).brightness
                  ? white
                  : dark,
            );
          } else if (state is CurrentTripState) {
            TripEntity trip = state.trip;
            return Stack(
              children: [
                TaxiAlongGoogleMap(
                  trip: trip,
                ),
                DraggableScrollableSheet(
                  initialChildSize: 0.4,
                  minChildSize: 0.3,
                  maxChildSize: 0.8,
                  builder: (BuildContext context,
                      ScrollController scrollController) {
                    return SingleChildScrollView(
                      controller: scrollController,
                      child: BottomSheetViewContent(
                        trip: trip,
                      ),
                    );
                  },
                ),
              ],
            );
          } else {
            return const TaxiAlongErrorWidget();
          }
        },
      ),
    );
  }
}

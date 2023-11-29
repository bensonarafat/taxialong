import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bus_stop_event.dart';
part 'bus_stop_state.dart';

class BusStopBloc extends Bloc<BusStopEvent, BusStopState> {
  BusStopBloc() : super(BusStopLoadingState());
}

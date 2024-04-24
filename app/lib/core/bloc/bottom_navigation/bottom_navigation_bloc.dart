import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxialong/core/bloc/bottom_navigation/bottom_navigation_event.dart';
import 'package:taxialong/core/bloc/bottom_navigation/bottom_navigation_state.dart';

class BottomNavigationBloc
    extends Bloc<BottomNavigateionEvent, BottomNavigationState> {
  BottomNavigationBloc() : super(const BottomNavigationInitial(index: 0)) {
    on<BottomNavigateionEvent>((event, emit) {
      if (event is TabChange) {
        emit(BottomNavigationInitial(index: event.index));
      }
    });
  }
}

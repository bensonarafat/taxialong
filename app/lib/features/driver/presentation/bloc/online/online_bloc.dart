import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/features/driver/domain/entities/go_online_entity.dart';
import 'package:taxialong/features/driver/domain/usecases/go_online_usecase.dart';

part 'online_state.dart';
part 'online_event.dart';

class OnlineBloc extends Bloc<OnlineEvent, OnlineState> {
  GoOnlineUseCase goOnlineUseCase;
  OnlineBloc({required this.goOnlineUseCase}) : super(OnlineInit()) {
    on<GoOnlineEvent>((event, emit) => driverHomeGoOnlineEvent(event, emit));
  }

  driverHomeGoOnlineEvent(event, emit) async {
    var failureOrOnline = await goOnlineUseCase({});

    emit(failureOrOnline.fold(
        (failure) => OnlineError(message: mapFailureToMessage(failure)),
        (goOnlineEntity) => OnlineUpdated(goOnlineEntity: goOnlineEntity)));
  }
}

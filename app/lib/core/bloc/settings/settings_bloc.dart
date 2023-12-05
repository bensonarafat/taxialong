import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxialong/core/domain/entities/account_switch_entity.dart';
import 'package:taxialong/core/domain/usecases/switch_account_usecase.dart';
import 'package:taxialong/core/utils/helpers.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SwitchAccountUseCase switchAccountUseCase;
  SettingsBloc({
    required this.switchAccountUseCase,
  }) : super(SettingInitial()) {
    on<SettingsEvent>((event, emit) async {
      if (event is SettingsSwitchAccountEvent) {
        emit(SettingsSwitchLoadingState());

        final failureOrSwitchEvent = await switchAccountUseCase({});

        emit(failureOrSwitchEvent.fold(
            (failure) =>
                SettingErrorState(message: mapFailureToMessage(failure)),
            (accountSwitchEntity) => SettingsSwitchedState(
                accountSwitchEntity: accountSwitchEntity)));
      }
    });
  }
}

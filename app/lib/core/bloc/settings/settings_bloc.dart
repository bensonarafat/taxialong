import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxialong/core/domain/entities/account_switch_entity.dart';
import 'package:taxialong/core/domain/entities/settings_update_entity.dart';
import 'package:taxialong/core/domain/usecases/get_terminals_usecase.dart';
import 'package:taxialong/core/domain/usecases/switch_account_usecase.dart';
import 'package:taxialong/core/domain/usecases/update_settings_usecase.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/core/domain/entities/terminal_entity.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SwitchAccountUseCase switchAccountUseCase;
  GetTermainalUseCase getTermainalUseCase;
  UpdateSettingsUseCase updateSettingsUseCase;
  SettingsBloc({
    required this.switchAccountUseCase,
    required this.getTermainalUseCase,
    required this.updateSettingsUseCase,
  }) : super(SettingInitial()) {
    on<RideFilterEvent>((event, emit) =>
        emit(FilterRideState(rideClass: event.rideClass, seat: event.seat)));
    on<UpdateSettingsEvent>((event, emit) => updateSettingsEvent(event, emit));
    on<SettingsGetTerminalsEvent>(
        (event, emit) => settingsGetTerminalsEvent(event, emit));
    on<SettingsSwitchAccountEvent>(
        (event, emit) => settingsSwitchAccountEvent(event, emit));
  }

  settingsSwitchAccountEvent(event, emit) async {
    emit(SettingsSwitchLoadingState());

    final failureOrSwitchEvent = await switchAccountUseCase({});

    emit(failureOrSwitchEvent.fold(
        (failure) => SettingErrorState(message: mapFailureToMessage(failure)),
        (accountSwitchEntity) =>
            SettingsSwitchedState(accountSwitchEntity: accountSwitchEntity)));
  }

  settingsGetTerminalsEvent(event, emit) async {
    emit(SettingsTerminalsLoadingState());
    var failureOrTerminalData = await getTermainalUseCase({});
    emit(failureOrTerminalData.fold(
        (failure) => SettingErrorState(message: mapFailureToMessage(failure)),
        (terminalEntity) =>
            SettingsTerminalsLoadedState(terminalEntity: terminalEntity)));
  }

  updateSettingsEvent(event, emit) async {
    emit(SettingsLoadingState());

    var failureOrSettingsData = await updateSettingsUseCase(
      SettingsParams(
        selectedClass: event.selectedClass,
        paymentMethod: event.paymentMethod,
        pointa: event.pointa,
        pointb: event.pointb,
      ),
    );
    emit(
      failureOrSettingsData.fold(
        (failure) => SettingErrorState(message: mapFailureToMessage(failure)),
        (settingsUpdateEntity) =>
            SettingsUpdatedState(settingsUpdateEntity: settingsUpdateEntity),
      ),
    );
  }
}

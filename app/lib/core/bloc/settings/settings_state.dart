part of 'settings_bloc.dart';

@immutable
abstract class SettingsState extends Equatable {}

class SettingInitial extends SettingsState {
  @override
  List<Object?> get props => [];
}

class SettingsSwitchLoadingState extends SettingsState {
  @override
  List<Object?> get props => [];
}

class SettingsSwitchedState extends SettingsState {
  final AccountSwitchEntity accountSwitchEntity;

  SettingsSwitchedState({required this.accountSwitchEntity});
  @override
  List<Object?> get props => [accountSwitchEntity];
}

class SettingErrorState extends SettingsState {
  final String message;

  SettingErrorState({required this.message});
  @override
  List<Object?> get props => [message];
}

class SettingsTerminalsLoadingState extends SettingsState {
  @override
  List<Object?> get props => [];
}

class SettingsLoadingState extends SettingsState {
  @override
  List<Object?> get props => [];
}

class SettingsTerminalsLoadedState extends SettingsState {
  final List<TerminalEntity> terminalEntity;
  SettingsTerminalsLoadedState({required this.terminalEntity});
  @override
  List<Object?> get props => [terminalEntity];
}

class SettingsUpdatedState extends SettingsState {
  final SettingsUpdateEntity settingsUpdateEntity;
  SettingsUpdatedState({
    required this.settingsUpdateEntity,
  });
  @override
  List<Object?> get props => [settingsUpdateEntity];
}

class FilterRideState extends SettingsState {
  final List<dynamic>? rideClass;

  FilterRideState({required this.rideClass});
  @override
  List<Object?> get props => [rideClass];
}

class SeatsLoadingState extends SettingsState {
  @override
  List<Object?> get props => [];
}

class SeatsLoadedState extends SettingsState {
  final List<SeatsEntity> seats;
  SeatsLoadedState({required this.seats});
  @override
  List<Object?> get props => [];
}

class SeatsErrorState extends SettingsState {
  final String message;

  SeatsErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

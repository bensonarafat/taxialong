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

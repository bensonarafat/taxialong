part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent extends Equatable {}

class SettingsSwitchAccountEvent extends SettingsEvent {
  @override
  List<Object?> get props => [];
}

class SettingsGetTerminalsEvent extends SettingsEvent {
  @override
  List<Object?> get props => [];
}

class UpdateSettingsEvent extends SettingsEvent {
  final int? pointa;
  final int? pointb;
  final String paymentMethod;

  UpdateSettingsEvent({
    required this.pointa,
    required this.pointb,
    required this.paymentMethod,
  });
  @override
  List<Object?> get props => [];
}

class RideFilterEvent extends SettingsEvent {
  final List<dynamic>? rideClass;

  RideFilterEvent({this.rideClass});

  @override
  List<Object?> get props => [rideClass];
}

class GetSeatsEvent extends SettingsEvent {
  @override
  List<Object?> get props => [];
}

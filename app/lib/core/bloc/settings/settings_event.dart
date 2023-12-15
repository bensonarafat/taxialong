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
  final String? pointa;
  final String? pointb;
  final List<Map<String, dynamic>>? selectedClass;
  final String paymentMethod;

  UpdateSettingsEvent({
    required this.pointa,
    required this.pointb,
    required this.selectedClass,
    required this.paymentMethod,
  });
  @override
  List<Object?> get props => [];
}

class RideFilterEvent extends SettingsEvent {
  final List<dynamic>? rideClass;
  final String? seat;

  RideFilterEvent({this.rideClass, this.seat});

  @override
  List<Object?> get props => [rideClass, seat];
}

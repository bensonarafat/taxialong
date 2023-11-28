part of 'home_bloc.dart';

@immutable
abstract class HomeEvent extends Equatable {}

class FetchHomeTerminals extends HomeEvent {
  final double? latitude;
  final double? longitude;

  FetchHomeTerminals({required this.latitude, required this.longitude});
  @override
  List<Object?> get props => [
        latitude,
        longitude,
      ];
}

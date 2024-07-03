part of 'recent_bloc.dart';

abstract class RecentEvent extends Equatable {}

class DriverHomeFetchRecents extends RecentEvent {
  final bool loading;

  DriverHomeFetchRecents({required this.loading});

  @override
  List<Object?> get props => [loading];
}

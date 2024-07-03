import 'package:taxialong/features/bus_stops/domain/entities/bus_stop_entity.dart';

class AxisEntity {
  final int id;
  final int pointa;
  final int pointb;
  final BusStopEntity busStop;

  AxisEntity({
    required this.id,
    required this.pointa,
    required this.pointb,
    required this.busStop,
  });
}

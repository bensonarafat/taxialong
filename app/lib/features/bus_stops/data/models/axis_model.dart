import 'package:taxialong/features/bus_stops/data/models/bus_stop_model.dart';
import 'package:taxialong/features/bus_stops/domain/entities/axis_entity.dart';

class AxisModel extends AxisEntity {
  AxisModel({
    required super.id,
    required super.pointa,
    required super.pointb,
    required super.busStop,
  });

  factory AxisModel.fromJson(Map<String, dynamic> json) {
    return AxisModel(
      id: json['id'],
      pointa: json['point_a'],
      pointb: json['point_b'],
      busStop: BusStopModel.fromJson(
        json['bus_stop'],
      ),
    );
  }
}

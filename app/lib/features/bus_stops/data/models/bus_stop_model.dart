import 'package:taxialong/features/bus_stops/domain/entities/bus_stop_entity.dart';

class BusStopModel extends BusStopEntity {
  BusStopModel({
    required super.id,
    required super.name,
    required super.latitude,
    required super.longitude,
  });

  factory BusStopModel.fromJson(Map<String, dynamic> json) {
    return BusStopModel(
      id: json['id'],
      name: json['name'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}

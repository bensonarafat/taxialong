import 'package:taxialong/features/home/domain/entities/terminal_entity.dart';

class TerminalModel extends TerminalEntity {
  TerminalModel({
    required super.id,
    required super.name,
    required super.latitude,
    required super.longitude,
  });

  factory TerminalModel.fromJson(Map<String, dynamic> json) {
    return TerminalModel(
      id: json['id'],
      name: json['name'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

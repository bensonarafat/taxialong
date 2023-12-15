import 'package:taxialong/features/rides/domain/entities/seats_entity.dart';

class SeatsModel extends SeatsEntity {
  SeatsModel({required super.seat, required super.status});

  factory SeatsModel.fromJson(Map<String, dynamic> json) {
    return SeatsModel(
      seat: json['seat'],
      status: json['status'],
    );
  }
}

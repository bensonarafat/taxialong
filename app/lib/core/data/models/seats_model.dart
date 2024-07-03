import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:taxialong/core/domain/entities/seats_entity.dart';

part 'seats_model.g.dart';

@JsonSerializable()
class SeatsModel extends SeatsEntity {
  SeatsModel({
    required super.id,
    required super.name,
    required super.seats,
    required super.total,
    required super.classes,
  });

  factory SeatsModel.fromJson(Map<String, dynamic> json) =>
      _$SeatsModelFromJson(json);

  Map<String, dynamic> toJson() => _$SeatsModelToJson(this);
}

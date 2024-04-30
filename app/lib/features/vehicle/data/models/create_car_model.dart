import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:taxialong/features/vehicle/domain/entities/create_car_entity.dart';

part 'create_car_model.g.dart';

@JsonSerializable()
class CreateCarModel extends CreateCarEntity {
  CreateCarModel({required super.status, required super.message});

  factory CreateCarModel.fromJson(Map<String, dynamic> json) =>
      _$CreateCarModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateCarModelToJson(this);
}

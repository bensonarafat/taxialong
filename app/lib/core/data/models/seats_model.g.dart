// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seats_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeatsModel _$SeatsModelFromJson(Map<String, dynamic> json) => SeatsModel(
      id: json['id'] as int,
      name: json['name'] as String,
      seats: json['seats'] as List<dynamic>,
      total: json['total'] as int,
      classes: json['classes'] as List<dynamic>?,
    );

Map<String, dynamic> _$SeatsModelToJson(SeatsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'total': instance.total,
      'seats': instance.seats,
      'classes': instance.classes,
    };

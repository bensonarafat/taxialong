import 'package:taxialong/features/documents/domain/entities/complete_entity.dart';

class CompleteModel extends CompleteEntity {
  CompleteModel({required super.status, required super.message});

  factory CompleteModel.fromJson(Map<String, dynamic> json) {
    return CompleteModel(status: json['status'], message: json['message']);
  }
}

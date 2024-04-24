import 'package:taxialong/features/trips/domain/entities/cancel_entity.dart';

class CancelModel extends CancelEntity {
  CancelModel({required super.status, required super.message});

  factory CancelModel.fromJson(Map<String, dynamic> json) {
    return CancelModel(status: json['status'], message: json['message']);
  }
}

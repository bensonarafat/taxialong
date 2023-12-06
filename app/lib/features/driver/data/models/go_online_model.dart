import 'package:taxialong/features/driver/domain/entities/go_online_entity.dart';

class GoOnlineModel extends GoOnlineEntity {
  GoOnlineModel({required super.status, required super.message});

  factory GoOnlineModel.fromJson(Map<String, dynamic> json) {
    return GoOnlineModel(status: json['status'], message: json['message']);
  }
}

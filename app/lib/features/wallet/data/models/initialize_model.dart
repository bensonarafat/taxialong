import 'package:taxialong/features/wallet/domain/entities/initialize_entity.dart';

class InitializeModel extends InitializeEntity {
  InitializeModel({
    required super.status,
    required super.message,
    required super.authorizationUrl,
    required super.accessCode,
    required super.reference,
  });

  factory InitializeModel.fromJson(Map<String, dynamic> json) {
    return InitializeModel(
      status: json['status'],
      message: json['message'],
      authorizationUrl: json['data']['authorization_url'],
      accessCode: json['data']['access_code'],
      reference: json['data']['reference'],
    );
  }
}

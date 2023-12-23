import 'package:taxialong/features/wallet/domain/entities/verify_payment_entity.dart';

class VerifyPaymentModel extends VerifyPaymentEntity {
  VerifyPaymentModel({required super.status});

  factory VerifyPaymentModel.fromJson(Map<String, dynamic> json) {
    return VerifyPaymentModel(status: json['status']);
  }
}

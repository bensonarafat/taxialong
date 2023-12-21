import 'package:taxialong/features/wallet/domain/entities/payment_method_entity.dart';

class PaymentMethodModel extends PaymentMethodEntity {
  PaymentMethodModel({required super.status, required super.message});

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) {
    return PaymentMethodModel(status: json['status'], message: json['message']);
  }
}

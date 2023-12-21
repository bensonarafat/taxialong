import 'package:taxialong/features/wallet/domain/entities/transaction_entity.dart';

class TransactionModel extends TransactionEntity {
  TransactionModel({
    required super.status,
    required super.message,
    required super.id,
    required super.type,
    required super.amount,
    required super.description,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> data = json['data'];
    return TransactionModel(
      status: json['status'],
      message: json['message'],
      id: data['id'],
      type: data['type'],
      amount: data['amount'],
      description: data['description'],
    );
  }
}

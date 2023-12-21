import 'package:taxialong/features/wallet/domain/entities/wallet_entity.dart';

class WalletModel extends WalletEntity {
  WalletModel(
      {required super.status,
      required super.message,
      required super.bonus,
      required super.fund});

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> data = json['data'];
    return WalletModel(
      status: json['bonus'],
      message: json['message'],
      bonus: data['bonus'],
      fund: data['fund'],
    );
  }
}

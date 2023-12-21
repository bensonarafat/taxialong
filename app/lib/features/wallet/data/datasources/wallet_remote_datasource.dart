import 'dart:convert';

import 'package:taxialong/core/constants/constants.dart';
import 'package:taxialong/core/error/execptions.dart';
import 'package:taxialong/core/services/secure_storage.dart';
import 'package:taxialong/features/wallet/data/models/payment_method_model.dart';
import 'package:taxialong/features/wallet/data/models/transaction_model.dart';
import 'package:taxialong/features/wallet/data/models/wallet_model.dart';
import 'package:taxialong/features/wallet/domain/usecases/update_payment_method_usecase.dart';

abstract class WalletRemoteDataSource {
  Future<List<TransactionModel>> getTransactions();
  Future<WalletModel> getWallet();
  Future<PaymentMethodModel> updatePaymentMethod(PaymentMethodParam param);
}

class WalletRemoteDataSourceImpl implements WalletRemoteDataSource {
  final dynamic client;
  final SecureStorage secureStorage;

  WalletRemoteDataSourceImpl(
      {required this.client, required this.secureStorage});
  @override
  Future<List<TransactionModel>> getTransactions() async {
    final token = await secureStorage.getToken();
    if (token == null) throw ServerException();
    var headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };
    var url = Uri.parse("${endpoint}transactions");
    final response = await client.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      List<dynamic> jsonresponse = data['data'];
      List<TransactionModel> list =
          jsonresponse.map((item) => TransactionModel.fromJson(item)).toList();
      return list;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<WalletModel> getWallet() async {
    final token = await secureStorage.getToken();
    if (token == null) throw ServerException();
    var headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };
    var url = Uri.parse("${endpoint}wallet");
    var response = await client.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      return WalletModel.fromJson(data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<PaymentMethodModel> updatePaymentMethod(
      PaymentMethodParam param) async {
    final token = await secureStorage.getToken();
    if (token == null) throw ServerException();
    var headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };
    var url = Uri.parse("${endpoint}wallet/update-payment-method");
    var response = await client.post(url, headers: headers, body: {
      "paymentMethod": param.paymentMethod,
    });

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      return PaymentMethodModel.fromJson(data);
    } else {
      throw ServerException();
    }
  }
}

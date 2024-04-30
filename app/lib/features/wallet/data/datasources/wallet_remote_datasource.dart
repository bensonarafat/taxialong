import 'package:dio/dio.dart';
import 'package:taxialong/core/constants/constants.dart';
import 'package:taxialong/core/data/models/user_model.dart';
import 'package:taxialong/core/error/execptions.dart';
import 'package:taxialong/core/services/secure_storage.dart';
import 'package:taxialong/features/wallet/data/models/initialize_model.dart';
import 'package:taxialong/features/wallet/data/models/payment_method_model.dart';
import 'package:taxialong/features/wallet/data/models/transaction_model.dart';
import 'package:taxialong/features/wallet/data/models/verify_payment_model.dart';
import 'package:taxialong/features/wallet/data/models/wallet_model.dart';
import 'package:taxialong/features/wallet/domain/usecases/update_payment_method_usecase.dart';

abstract class WalletRemoteDataSource {
  Future<List<TransactionModel>> getTransactions();
  Future<WalletModel> getWallet();
  Future<InitializeModel> initializePayment(params);
  Future<PaymentMethodModel> updatePaymentMethod(PaymentMethodParam param);
  Future<VerifyPaymentModel> verifyPayment(params);
}

class WalletRemoteDataSourceImpl implements WalletRemoteDataSource {
  final Dio dio;
  final SecureStorage secureStorage;

  WalletRemoteDataSourceImpl({required this.dio, required this.secureStorage}) {
    dio.options.headers["Accept"] = "application/json";
  }
  @override
  Future<List<TransactionModel>> getTransactions() async {
    final token = await secureStorage.getToken();
    if (token == null) throw ServerException();
    dio.options.headers["Authorization"] = 'Bearer $token';
    dio.options.headers["Accept"] = "application/json";
    var url = "${endpoint}transactions";
    final response = await dio.get(
      url,
    );

    if (response.statusCode == 200) {
      var data = response.data;

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
    dio.options.headers["Authorization"] = 'Bearer $token';
    dio.options.headers["Accept"] = "application/json";
    var url = "${endpoint}wallet";
    var response = await dio.get(
      url,
    );

    if (response.statusCode == 200) {
      var data = response.data;

      return WalletModel.fromJson(data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<PaymentMethodModel> updatePaymentMethod(
      PaymentMethodParam param) async {
    final token = await secureStorage.getToken();
    // print("Token $token");
    if (token == null) throw ServerException();

    dio.options.headers["Authorization"] = 'Bearer $token';
    dio.options.headers["Accept"] = "application/json";
    var url = "${endpoint}wallet/update-payment-method";
    var response = await dio.post(url, data: {
      "paymentMethod": param.paymentMethod,
    });

    if (response.statusCode == 200) {
      var data = response.data;

      return PaymentMethodModel.fromJson(data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<InitializeModel> initializePayment(params) async {
    final UserModel? userModel = await secureStorage.getUserData();
    if (userModel == null) throw ServerException();
    dio.options.headers["Authorization"] = 'Bearer $paystackSecretKey';

    var response = await dio.post(paystackInitializeEndpoint, data: {
      "email": userModel.email,
      "amount": (int.parse(params.amount) * 100).toString(),
      "callback_url": "${endpoint}paystack-callback",
    });

    if (response.statusCode == 200) {
      var data = response.data;

      return InitializeModel.fromJson(data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<VerifyPaymentModel> verifyPayment(params) async {
    final token = await secureStorage.getToken();
    if (token == null) throw ServerException();
    dio.options.headers["Authorization"] = 'Bearer $token';
    var url = "${endpoint}wallet/verify-payment/${params.reference}";
    var response = await dio.get(url);

    if (response.statusCode == 200) {
      var data = response.data;

      return VerifyPaymentModel.fromJson(data);
    } else {
      throw ServerException();
    }
  }
}

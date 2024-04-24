import 'package:dartz/dartz.dart';
import 'package:taxialong/core/connection/network_info.dart';
import 'package:taxialong/core/data/datasources/remote_user_data_source.dart';
import 'package:taxialong/core/data/models/user_model.dart';
import 'package:taxialong/core/error/execptions.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/core/services/secure_storage.dart';
import 'package:taxialong/features/wallet/data/datasources/wallet_remote_datasource.dart';
import 'package:taxialong/features/wallet/data/models/initialize_model.dart';
import 'package:taxialong/features/wallet/data/models/payment_method_model.dart';
import 'package:taxialong/features/wallet/data/models/transaction_model.dart';
import 'package:taxialong/features/wallet/data/models/verify_payment_model.dart';
import 'package:taxialong/features/wallet/data/models/wallet_model.dart';
import 'package:taxialong/features/wallet/domain/repositories/wallet_repository.dart';

class WalletRepositoryImpl implements WalletRepository {
  final NetworkInfo networkInfo;
  final WalletRemoteDataSource remoteDataSource;
  UserDataSource userDataSource;
  SecureStorage secureStorage;
  WalletRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.userDataSource,
    required this.secureStorage,
  });

  @override
  Future<Either<Failure, List<TransactionModel>>> getTransactions() async {
    if (await networkInfo.isConnected) {
      try {
        List<TransactionModel> transactionsList =
            await remoteDataSource.getTransactions();
        return Right(transactionsList);
      } on ServerException {
        return Left(ServerFailure(message: "There is a server failure"));
      }
    } else {
      return Left(
          NetworkFailure(message: 'Please check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, WalletModel>> getWallet() async {
    if (await networkInfo.isConnected) {
      try {
        WalletModel walletModel = await remoteDataSource.getWallet();
        return Right(walletModel);
      } on ServerException {
        return Left(ServerFailure(message: "There is a server failure"));
      }
    } else {
      return Left(
          NetworkFailure(message: 'Please check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, PaymentMethodModel>> updatePaymentMethod(param) async {
    if (await networkInfo.isConnected) {
      try {
        PaymentMethodModel paymentMethodModel =
            await remoteDataSource.updatePaymentMethod(param);
        // get data and save to device
        UserModel userModel = await userDataSource.getUserData();
        secureStorage.saveUserData(userModel);

        return Right(paymentMethodModel);
      } on ServerException {
        return Left(ServerFailure(message: "There is a server failure"));
      }
    } else {
      return Left(
          NetworkFailure(message: 'Please check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, InitializeModel>> initializePayment(params) async {
    if (await networkInfo.isConnected) {
      try {
        InitializeModel initializeModel =
            await remoteDataSource.initializePayment(params);

        return Right(initializeModel);
      } on ServerException {
        return Left(ServerFailure(message: "There is a server failure"));
      }
    } else {
      return Left(
          NetworkFailure(message: 'Please check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, VerifyPaymentModel>> verifyPayment(params) async {
    if (await networkInfo.isConnected) {
      try {
        VerifyPaymentModel verifyPaymentModel =
            await remoteDataSource.verifyPayment(params);

        return Right(verifyPaymentModel);
      } on ServerException {
        return Left(ServerFailure(message: "There is a server failure"));
      }
    } else {
      return Left(
          NetworkFailure(message: 'Please check your internet connection'));
    }
  }
}

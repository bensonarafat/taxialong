import 'package:dartz/dartz.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/features/wallet/domain/entities/payment_method_entity.dart';
import 'package:taxialong/features/wallet/domain/entities/transaction_entity.dart';
import 'package:taxialong/features/wallet/domain/entities/wallet_entity.dart';

abstract class WalletRepository {
  Future<Either<Failure, WalletEntity>> getWallet();
  Future<Either<Failure, List<TransactionEntity>>> getTransactions();
  Future<Either<Failure, PaymentMethodEntity>> updatePaymentMethod(param);
}

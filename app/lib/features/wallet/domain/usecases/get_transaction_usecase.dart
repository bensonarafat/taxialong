import 'package:dartz/dartz.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/core/usecases/usecase.dart';
import 'package:taxialong/features/wallet/domain/entities/transaction_entity.dart';
import 'package:taxialong/features/wallet/domain/repositories/wallet_repository.dart';

class GetTransactionUseCase extends UseCase<List<TransactionEntity>, void> {
  WalletRepository repository;
  GetTransactionUseCase({required this.repository});
  @override
  Future<Either<Failure, List<TransactionEntity>>> call(void params) async {
    return await repository.getTransactions();
  }
}

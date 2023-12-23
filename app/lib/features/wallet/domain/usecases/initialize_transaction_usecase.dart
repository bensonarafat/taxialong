import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/core/usecases/usecase.dart';
import 'package:taxialong/features/wallet/domain/entities/initialize_entity.dart';
import 'package:taxialong/features/wallet/domain/repositories/wallet_repository.dart';

class InitializePaymentUseCase
    extends UseCase<InitializeEntity, InitializeParams> {
  WalletRepository repository;
  InitializePaymentUseCase({required this.repository});
  @override
  Future<Either<Failure, InitializeEntity>> call(
    InitializeParams params,
  ) async {
    return await repository.initializePayment(params);
  }
}

class InitializeParams extends Equatable {
  final String amount;

  const InitializeParams({required this.amount});

  @override
  List<Object?> get props => [amount];
}

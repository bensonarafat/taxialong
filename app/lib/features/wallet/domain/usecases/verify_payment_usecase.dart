import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/core/usecases/usecase.dart';
import 'package:taxialong/features/wallet/domain/entities/verify_payment_entity.dart';
import 'package:taxialong/features/wallet/domain/repositories/wallet_repository.dart';

class VerifyPaymentUseCase
    extends UseCase<VerifyPaymentEntity, VerifyPaymentParams> {
  WalletRepository repository;
  VerifyPaymentUseCase({required this.repository});
  @override
  Future<Either<Failure, VerifyPaymentEntity>> call(
      VerifyPaymentParams params) async {
    return await repository.verifyPayment(params);
  }
}

class VerifyPaymentParams extends Equatable {
  final String reference;

  const VerifyPaymentParams({required this.reference});

  @override
  List<Object?> get props => [reference];
}

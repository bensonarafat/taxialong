import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/core/usecases/usecase.dart';
import 'package:taxialong/features/wallet/domain/entities/payment_method_entity.dart';
import 'package:taxialong/features/wallet/domain/repositories/wallet_repository.dart';

class UpdatePaymentMethodUseCase
    implements UseCase<PaymentMethodEntity, PaymentMethodParam> {
  WalletRepository repository;

  UpdatePaymentMethodUseCase({required this.repository});

  @override
  Future<Either<Failure, PaymentMethodEntity>> call(
      PaymentMethodParam param) async {
    return await repository.updatePaymentMethod(param);
  }
}

class PaymentMethodParam extends Equatable {
  final String paymentMethod;

  const PaymentMethodParam({required this.paymentMethod});
  @override
  List<Object?> get props => [paymentMethod];
}

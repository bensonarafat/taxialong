part of 'wallet_bloc.dart';

@immutable
abstract class WalletEvent extends Equatable {}

class FetchWalletEvent extends WalletEvent {
  @override
  List<Object?> get props => [];
}

class FetchTransactionEvent extends WalletEvent {
  @override
  List<Object?> get props => [];
}

class UpdatePaymentMethodEvent extends WalletEvent {
  final String paymentMethod;

  UpdatePaymentMethodEvent({required this.paymentMethod});

  @override
  List<Object?> get props => [paymentMethod];
}

class InitializePaymentEvent extends WalletEvent {
  final String amount;

  InitializePaymentEvent({required this.amount});

  @override
  List<Object?> get props => [amount];
}

class VerifyPaymentEvent extends WalletEvent {
  final String? reference;

  VerifyPaymentEvent({required this.reference});

  @override
  List<Object?> get props => [reference];
}

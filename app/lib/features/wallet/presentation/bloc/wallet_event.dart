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

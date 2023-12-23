part of 'wallet_bloc.dart';

@immutable
abstract class WalletState extends Equatable {}

class WalletInitialState extends WalletState {
  @override
  List<Object?> get props => [];
}

class WalletLoadingState extends WalletState {
  @override
  List<Object?> get props => [];
}

class TransactionLoadingState extends WalletState {
  @override
  List<Object?> get props => [];
}

class TransactionErrorState extends WalletState {
  final String message;

  TransactionErrorState({required this.message});
  @override
  List<Object?> get props => [message];
}

class WalletErrorState extends WalletState {
  final String message;

  WalletErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class WalletLoadedState extends WalletState {
  final WalletEntity walletEntity;

  WalletLoadedState({required this.walletEntity});

  @override
  List<Object?> get props => [walletEntity];
}

class TransactionLoadedState extends WalletState {
  final List<TransactionEntity> transactionEntity;

  TransactionLoadedState({required this.transactionEntity});

  @override
  List<Object?> get props => [transactionEntity];
}

class InitializePaymentLoading extends WalletState {
  @override
  List<Object?> get props => [];
}

class InitializePaymentLoaded extends WalletState {
  final InitializeEntity initializeEntity;

  InitializePaymentLoaded({required this.initializeEntity});
  @override
  List<Object?> get props => [initializeEntity];
}

class VerifyPaymentLoaded extends WalletState {
  final VerifyPaymentEntity verifyPaymentEntity;

  VerifyPaymentLoaded({required this.verifyPaymentEntity});
  @override
  List<Object?> get props => [verifyPaymentEntity];
}

class PaymentFailed extends WalletState {
  PaymentFailed();
  @override
  List<Object?> get props => [];
}

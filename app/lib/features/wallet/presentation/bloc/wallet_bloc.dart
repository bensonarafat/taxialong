import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/features/wallet/domain/entities/initialize_entity.dart';
import 'package:taxialong/features/wallet/domain/entities/transaction_entity.dart';
import 'package:taxialong/features/wallet/domain/entities/wallet_entity.dart';
import 'package:taxialong/features/wallet/domain/usecases/get_transaction_usecase.dart';
import 'package:taxialong/features/wallet/domain/usecases/get_wallet_usecase.dart';
import 'package:taxialong/features/wallet/domain/usecases/initialize_transaction_usecase.dart';
import 'package:taxialong/features/wallet/domain/usecases/update_payment_method_usecase.dart';

part 'wallet_state.dart';
part 'wallet_event.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final GetWalletUseCase getWalletUseCase;
  final GetTransactionUseCase getTransactionUseCase;
  final UpdatePaymentMethodUseCase updatePaymentMethodUseCase;
  final InitializePaymentUseCase initializePaymentUseCase;
  WalletBloc({
    required this.getTransactionUseCase,
    required this.getWalletUseCase,
    required this.updatePaymentMethodUseCase,
    required this.initializePaymentUseCase,
  }) : super(WalletInitialState()) {
    on<WalletEvent>((event, emit) async {
      if (event is FetchTransactionEvent) {
        emit(WalletLoadingState());

        final failureOrTransactionUsecase = await getTransactionUseCase({});

        emit(failureOrTransactionUsecase.fold(
            (failure) =>
                TransactionErrorState(message: mapFailureToMessage(failure)),
            (transactionEntity) =>
                TransactionLoadedState(transactionEntity: transactionEntity)));
      } else if (event is FetchWalletEvent) {
        emit(TransactionLoadingState());

        final failureOrWalletUsecase = await getWalletUseCase({});

        emit(failureOrWalletUsecase.fold(
            (failure) =>
                WalletErrorState(message: mapFailureToMessage(failure)),
            (walletEntity) => WalletLoadedState(walletEntity: walletEntity)));
      } else if (event is UpdatePaymentMethodEvent) {
        await updatePaymentMethodUseCase(
          PaymentMethodParam(
            paymentMethod: event.paymentMethod,
          ),
        );
      } else if (event is InitializePaymentEvent) {
        emit(InitializePaymentLoading());

        final failureOrInitUsecase = await initializePaymentUseCase(
            InitializeParams(amount: event.amount));

        emit(failureOrInitUsecase.fold(
            (failure) =>
                WalletErrorState(message: mapFailureToMessage(failure)),
            (initializeEntity) =>
                InitializePaymentLoaded(initializeEntity: initializeEntity)));
      }
    });
  }
}

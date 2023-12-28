import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/features/wallet/domain/entities/initialize_entity.dart';
import 'package:taxialong/features/wallet/domain/entities/transaction_entity.dart';
import 'package:taxialong/features/wallet/domain/entities/verify_payment_entity.dart';
import 'package:taxialong/features/wallet/domain/entities/wallet_entity.dart';
import 'package:taxialong/features/wallet/domain/usecases/get_transaction_usecase.dart';
import 'package:taxialong/features/wallet/domain/usecases/get_wallet_usecase.dart';
import 'package:taxialong/features/wallet/domain/usecases/initialize_transaction_usecase.dart';
import 'package:taxialong/features/wallet/domain/usecases/update_payment_method_usecase.dart';
import 'package:taxialong/features/wallet/domain/usecases/verify_payment_usecase.dart';

part 'wallet_state.dart';
part 'wallet_event.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final GetWalletUseCase getWalletUseCase;
  final GetTransactionUseCase getTransactionUseCase;
  final UpdatePaymentMethodUseCase updatePaymentMethodUseCase;
  final InitializePaymentUseCase initializePaymentUseCase;
  final VerifyPaymentUseCase verifyPaymentUseCase;
  WalletBloc({
    required this.getTransactionUseCase,
    required this.getWalletUseCase,
    required this.updatePaymentMethodUseCase,
    required this.initializePaymentUseCase,
    required this.verifyPaymentUseCase,
  }) : super(WalletInitialState()) {
    on<FetchTransactionEvent>(
        (event, emit) => fetchTransactionEvent(event, emit));
    on<FetchWalletEvent>((event, emit) => fetchWalletEvent(event, emit));
    on<UpdatePaymentMethodEvent>(
        (event, emit) => updatePaymentMethodEvent(event, emit));
    on<InitializePaymentEvent>(
        (event, emit) => initializePaymentEvent(event, emit));

    on<VerifyPaymentEvent>((event, emit) => verifyPaymentEvent(event, emit));
  }

  verifyPaymentEvent(event, emit) async {
    emit(WalletLoadingState());

    if (event.reference != null) {
      final failureOrVerifyUsecase = await verifyPaymentUseCase(
          VerifyPaymentParams(reference: event.reference!));
      emit(failureOrVerifyUsecase.fold(
          (failure) => WalletErrorState(message: mapFailureToMessage(failure)),
          (verifyPaymentEntity) =>
              VerifyPaymentLoaded(verifyPaymentEntity: verifyPaymentEntity)));
    } else {
      emit(PaymentFailed());
    }
  }

  initializePaymentEvent(event, emit) async {
    emit(InitializePaymentLoading());

    final failureOrInitUsecase =
        await initializePaymentUseCase(InitializeParams(amount: event.amount));

    emit(failureOrInitUsecase.fold(
        (failure) => WalletErrorState(message: mapFailureToMessage(failure)),
        (initializeEntity) =>
            InitializePaymentLoaded(initializeEntity: initializeEntity)));
  }

  updatePaymentMethodEvent(event, emit) async {
    await updatePaymentMethodUseCase(
      PaymentMethodParam(
        paymentMethod: event.paymentMethod,
      ),
    );
  }

  fetchTransactionEvent(event, emit) async {
    emit(WalletLoadingState());

    final failureOrTransactionUsecase = await getTransactionUseCase({});

    emit(failureOrTransactionUsecase.fold(
        (failure) =>
            TransactionErrorState(message: mapFailureToMessage(failure)),
        (transactionEntity) =>
            TransactionLoadedState(transactionEntity: transactionEntity)));
  }

  fetchWalletEvent(event, emit) async {
    emit(TransactionLoadingState());

    final failureOrWalletUsecase = await getWalletUseCase({});

    emit(failureOrWalletUsecase.fold(
        (failure) => WalletErrorState(message: mapFailureToMessage(failure)),
        (walletEntity) => WalletLoadedState(walletEntity: walletEntity)));
  }
}

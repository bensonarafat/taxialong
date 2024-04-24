import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxialong/core/services/get_it_services.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/core/widgets/taxi_along_error_page.dart';
import 'package:taxialong/core/widgets/taxi_along_loading.dart';
import 'package:taxialong/core/widgets/taxi_along_payment_failed_page.dart';
import 'package:taxialong/core/widgets/taxi_along_payment_success_page.dart';
import 'package:taxialong/features/wallet/domain/entities/verify_payment_entity.dart';
import 'package:taxialong/features/wallet/presentation/bloc/wallet_bloc.dart';

class VerifyPayment extends StatelessWidget {
  final Map<String, dynamic> params;
  const VerifyPayment({
    super.key,
    required this.params,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WalletBloc>(
      create: (context) => getIt<WalletBloc>()
        ..add(VerifyPaymentEvent(reference: params['reference'])),
      child: Scaffold(
        body: BlocBuilder<WalletBloc, WalletState>(
          builder: (context, state) {
            if (state is WalletErrorState) {
              return const TaxiAlongPaymentFailedPage();
            } else if (state is PaymentFailed) {
              return const TaxiAlongPaymentFailedPage();
            } else if (state is WalletLoadingState) {
              return TaxiAlongLoading(
                color: Theme.of(context).brightness == Brightness.dark
                    ? white
                    : dark,
              );
            } else if (state is VerifyPaymentLoaded) {
              VerifyPaymentEntity verifyPaymentEntity =
                  state.verifyPaymentEntity;
              if (verifyPaymentEntity.status) {
                return TaxiAlongPaymentSuccessPage(
                  reference: params['reference'],
                  amount: verifyPaymentEntity.amount.toString(),
                );
              } else {
                return const TaxiAlongPaymentFailedPage();
              }
            } else {
              return const TaxiAlongErrorPage();
            }
          },
        ),
      ),
    );
  }
}

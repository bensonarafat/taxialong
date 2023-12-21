import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/core/widgets/taxi_along_error_widget.dart';
import 'package:taxialong/core/widgets/taxi_along_loading.dart';
import 'package:taxialong/features/wallet/domain/entities/transaction_entity.dart';
import 'package:taxialong/features/wallet/presentation/bloc/wallet_bloc.dart';
import 'package:taxialong/features/wallet/presentation/widgets/wallet_topup.dart';
import 'package:taxialong/features/wallet/presentation/widgets/wallet_withdrawal.dart';

class Transactions extends StatelessWidget {
  const Transactions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletBloc, WalletState>(
      buildWhen: (pre, state) {
        return state is TransactionLoadingState ||
            state is TransactionLoadedState;
      },
      builder: (context, state) {
        if (state is TransactionLoadingState) {
          return TaxiAlongLoading(
            color:
                Theme.of(context).brightness == Brightness.dark ? white : dark,
          );
        } else if (state is TransactionLoadedState) {
          List<TransactionEntity> tranactionEntity = state.transactionEntity;
          return ListView.separated(
            separatorBuilder: (context, index) => Gap(8.h),
            shrinkWrap: true,
            itemCount: tranactionEntity.length,
            itemBuilder: (context, index) {
              if (tranactionEntity[index].type == 'credit') {
                return WalletTopUp(transaction: tranactionEntity[index]);
              } else {
                return WalletWithdrawal(transaction: tranactionEntity[index]);
              }
            },
          );
        } else {
          return const TaxiAlongErrorWidget();
        }
      },
    );
  }
}

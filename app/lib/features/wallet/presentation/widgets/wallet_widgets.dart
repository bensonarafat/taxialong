import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/core/widgets/taxi_along_error_widget.dart';
import 'package:taxialong/core/widgets/taxi_along_loading.dart';
import 'package:taxialong/features/wallet/domain/entities/wallet_entity.dart';
import 'package:taxialong/features/wallet/presentation/bloc/wallet_bloc.dart';
import 'package:taxialong/features/wallet/presentation/widgets/wallet_available_balance.dart';
import 'package:taxialong/features/wallet/presentation/widgets/wallet_bonus_balance.dart';

class WalletWidgets extends StatelessWidget {
  const WalletWidgets({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WalletBloc, WalletState>(
      buildWhen: (pre, state) {
        return state is WalletLoadingState || state is WalletLoadedState;
      },
      listener: (context, state) {
        if (state is WalletErrorState) {
          toast(state.message);
        }
      },
      builder: (context, state) {
        if (state is WalletLoadingState) {
          return TaxiAlongLoading(
            color:
                Theme.of(context).brightness == Brightness.dark ? white : dark,
          );
        } else if (state is WalletLoadedState) {
          WalletEntity walletEntity = state.walletEntity;
          return Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(156, 194, 225, 0.10),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Row(
              children: [
                WalletAvailableBalance(
                  wallet: walletEntity.fund,
                ),
                Gap(16.w),
                WalletBonusBalance(
                  wallet: walletEntity.bonus,
                ),
              ],
            ),
          );
        } else {
          return const TaxiAlongErrorWidget();
        }
      },
    );
  }
}

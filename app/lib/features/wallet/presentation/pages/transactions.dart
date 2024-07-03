import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:taxialong/core/services/get_it_services.dart';
import 'package:taxialong/features/wallet/presentation/bloc/wallet_bloc.dart';
import 'package:taxialong/features/wallet/presentation/widgets/transactions.dart'
    as transaction_widgets;

class Transactions extends StatelessWidget {
  const Transactions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WalletBloc>(
      create: (context) => getIt<WalletBloc>()..add(FetchTransactionEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Transactions',
          ),
          leading: GestureDetector(
            onTap: () {
              context.pop();
            },
            child: IconTheme(
              data: Theme.of(context).iconTheme,
              child: const Icon(
                Icons.keyboard_arrow_left,
              ),
            ),
          ),
        ),
        body: Container(
            margin: EdgeInsets.all(16.w),
            child: const transaction_widgets.Transactions()),
      ),
    );
  }
}

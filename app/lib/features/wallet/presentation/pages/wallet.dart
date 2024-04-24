import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxialong/core/constants/assets.dart';
import 'package:taxialong/core/services/get_it_services.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxialong/core/widgets/taxi_along_search_container.dart';
import 'package:taxialong/features/wallet/presentation/bloc/wallet_bloc.dart';
import 'package:taxialong/core/widgets/taxi_along_wallet_payment_method.dart';
import 'package:taxialong/features/wallet/presentation/widgets/transactions.dart';
import 'package:taxialong/features/wallet/presentation/widgets/wallet_widgets.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<WalletBloc>(
      create: (_) => getIt<WalletBloc>()
        ..add(FetchWalletEvent())
        ..add(FetchTransactionEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const SearchContainer(),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: SvgPicture.asset(
                notificationSVG,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).brightness == Brightness.dark
                      ? white
                      : dark,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
          leading: Padding(
            padding: EdgeInsets.only(left: 16.w, right: 16.w),
            child: GestureDetector(
              onTap: () {
                // Scaffold.of(context).openDrawer();
              },
              child: SvgPicture.asset(
                menu,
                width: 24.w,
                height: 24.h,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).brightness == Brightness.dark
                      ? white
                      : dark,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(16.w),
            child: Column(
              children: [
                const WalletWidgets(),
                Gap(16.h),
                Builder(builder: (context) {
                  return WalletPaymentMethod(
                    paymentMethod: 'cash',
                    callback: (paymentMethod) {
                      context.read<WalletBloc>().add(UpdatePaymentMethodEvent(
                          paymentMethod: paymentMethod));
                    },
                  );
                }),
                Gap(16.h),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Transections",
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "See All",
                        textAlign: TextAlign.end,
                        style: GoogleFonts.robotoFlex(
                          color: primaryColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Gap(16.h),
                  ],
                ),
                Gap(16.h),
                const Transactions(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

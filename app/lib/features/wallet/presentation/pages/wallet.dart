import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxialong/core/constants/assets.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxialong/core/widgets/taxi_along_search_container.dart';
import 'package:taxialong/features/wallet/presentation/widgets/wallet_available_balance.dart';
import 'package:taxialong/features/wallet/presentation/widgets/wallet_bonus_balance.dart';
import 'package:taxialong/core/widgets/taxi_along_wallet_payment_method.dart';
import 'package:taxialong/features/wallet/presentation/widgets/wallet_topup.dart';
import 'package:taxialong/features/wallet/presentation/widgets/wallet_withdrawal.dart';

selected() {}

class Wallet extends StatelessWidget {
  const Wallet({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> key = GlobalKey();
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: const SearchContainer(),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: SvgPicture.asset(
              notificationSVG,
              colorFilter: ColorFilter.mode(
                Theme.of(context).brightness == Brightness.dark ? white : dark,
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
                Theme.of(context).brightness == Brightness.dark ? white : dark,
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
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(156, 194, 225, 0.10),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Row(
                  children: [
                    const WalletAvailableBalance(),
                    Gap(16.w),
                    const WalletBonusBalance(),
                  ],
                ),
              ),
              Gap(16.h),
              const WalletPaymentMethod(
                paymentMethod: 'cash',
                callback: selected,
              ),
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
              const WalletTopUp(),
              Gap(8.h),
              const WalletWithdrawal(),
              Gap(8.h),
              const WalletTopUp(),
              Gap(8.h),
              const WalletWithdrawal(),
              Gap(8.h),
              const WalletTopUp(),
            ],
          ),
        ),
      ),
    );
  }
}

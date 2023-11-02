import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taxialong/core/constants/assets.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxialong/core/widgets/taxi_along_search_container.dart';
import 'package:taxialong/features/wallet/presentation/widgets/wallet_available_balance.dart';
import 'package:taxialong/features/wallet/presentation/widgets/wallet_bonus_balance.dart';
import 'package:taxialong/features/wallet/presentation/widgets/wallet_topup.dart';
import 'package:taxialong/features/wallet/presentation/widgets/wallet_withdrawal.dart';

class Wallet extends StatelessWidget {
  const Wallet({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> key = GlobalKey();
    return Scaffold(
      backgroundColor: dark,
      key: key,
      appBar: AppBar(
        backgroundColor: dark,
        elevation: 0,
        title: const SearchContainer(),
        centerTitle: true,
        actions: [
          Image.asset(belldark),
        ],
        leading: Image.asset(
          menudark,
          width: 24.w,
          height: 20.62.h,
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
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Transections",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: white,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "See All",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Gap(16.h),
                ],
              ),
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

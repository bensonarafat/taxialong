import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:taxialong/core/constants/assets.dart';
import 'package:taxialong/core/utils/colors.dart';

class WalletBonusBalance extends StatefulWidget {
  final int wallet;
  const WalletBonusBalance({
    super.key,
    required this.wallet,
  });

  @override
  State<WalletBonusBalance> createState() => _WalletBonusBalanceState();
}

class _WalletBonusBalanceState extends State<WalletBonusBalance> {
  bool ishide = false;

  hideUnHide() {
    setState(() {
      ishide = !ishide;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 16.w,
        horizontal: 4.h,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: primaryColor,
        ),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  right: 4.w,
                  left: 4.w,
                ),
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 111.w,
                      child: Text(
                        ishide ? "***" : "₦ ${widget.wallet}",
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                      ),
                    ),
                    GestureDetector(
                        onTap: () => hideUnHide(), child: Image.asset(eye)),
                  ],
                ),
              ),
            ],
          ),
          Gap(8.h),
          Text(
            "Bonus Balance",
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.w400,
                ),
          ),
          Gap(16.h),
          Container(
            width: 128.5.w,
            height: 42.h,
            padding: EdgeInsets.only(
              left: 16.w,
              right: 16.w,
            ),
            child: TextButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
              ),
              onPressed: () => context.push("/withdraw-fund"),
              child: Text(
                "Withdraw",
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: white,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

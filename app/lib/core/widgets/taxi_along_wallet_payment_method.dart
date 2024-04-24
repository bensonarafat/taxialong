import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:taxialong/core/constants/assets.dart';
import 'package:taxialong/core/data/models/user_model.dart';
import 'package:taxialong/core/services/get_it_services.dart';
import 'package:taxialong/core/services/secure_storage.dart';
import 'package:taxialong/core/utils/colors.dart';

class WalletPaymentMethod extends StatefulWidget {
  final String paymentMethod;
  final Function callback;
  const WalletPaymentMethod({
    super.key,
    required this.paymentMethod,
    required this.callback,
  });

  @override
  State<WalletPaymentMethod> createState() => _WalletPaymentMethodState();
}

class _WalletPaymentMethodState extends State<WalletPaymentMethod> {
  late String selected;
  SecureStorage secureStorage = getIt<SecureStorage>();
  String paymentMethod = "cash";
  @override
  void initState() {
    selected = widget.paymentMethod;
    _getUserData();
    super.initState();
  }

  _getUserData() async {
    UserModel? usermodel = await secureStorage.getUserData();
    setState(() {
      selected = usermodel?.settings?.paymentMethod ?? "cash";
    });
  }

  selectedFunc(paymentMethod) {
    widget.callback(paymentMethod);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
      decoration: ShapeDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF181818)
            : const Color.fromRGBO(156, 194, 225, 0.10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              'Payment Methods',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 20.sp,
                  ),
            ),
          ),
          Gap(16.h),
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1.w, color: const Color(0xFF333333)),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Radio(
                  value: 'cash',
                  onChanged: (value) {
                    setState(() {
                      selectedFunc(value);
                      selected = value!;
                    });
                  },
                  groupValue: selected,
                ),
                Gap(16.w),
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 40.w,
                        height: 40.h,
                        padding: EdgeInsets.all(8.r),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? white
                              : primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: SvgPicture.asset(
                          cashSVG,
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).brightness == Brightness.dark
                                ? primaryColor
                                : white,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      Gap(12.w),
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Cash',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16.sp,
                                          color: primaryColor),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Gap(16.h),
          Container(
            padding: EdgeInsets.all(8.w),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Radio(
                  value: 'wallet',
                  onChanged: (value) {
                    setState(() {
                      selectedFunc(value);
                      selected = value!;
                    });
                  },
                  groupValue: selected,
                ),
                Gap(16.w),
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 40.w,
                        height: 40.h,
                        padding: EdgeInsets.all(8.r),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? white
                              : primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r)),
                        ),
                        child: SvgPicture.asset(
                          walletSVG,
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).brightness == Brightness.dark
                                ? primaryColor
                                : white,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      Gap(12.w),
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Wallet',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16.sp,
                                          color: primaryColor),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

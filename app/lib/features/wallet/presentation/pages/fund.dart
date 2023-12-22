import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxialong/core/services/get_it_services.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/core/widgets/taxi_along_loading.dart';
import 'package:taxialong/features/wallet/domain/entities/initialize_entity.dart';
import 'package:taxialong/features/wallet/presentation/bloc/wallet_bloc.dart';

class Fund extends StatefulWidget {
  const Fund({super.key});

  @override
  State<Fund> createState() => _FundState();
}

class _FundState extends State<Fund> {
  TextEditingController amountcontroller = TextEditingController();

  @override
  void dispose() {
    amountcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WalletBloc>(
      create: (context) => getIt<WalletBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Fund Wallet',
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
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: EdgeInsets.all(16.w),
                child: SizedBox(
                  width: 358.w,
                  child: TextFormField(
                    controller: amountcontroller,
                    maxLength: 5,
                    autofocus: true,
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "0",
                      hintStyle:
                          Theme.of(context).textTheme.displayLarge!.copyWith(
                                fontWeight: FontWeight.w900,
                              ),
                      prefix: Container(
                        padding: EdgeInsets.only(right: 8.w),
                        child: Text(
                          "₦",
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(
                                fontWeight: FontWeight.w900,
                              ),
                        ),
                      ),
                      suffix: Text(
                        ".00",
                        style:
                            Theme.of(context).textTheme.displayLarge!.copyWith(
                                  fontWeight: FontWeight.w900,
                                ),
                      ),
                      counterText: '',
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: BlocConsumer<WalletBloc, WalletState>(
                listener: (context, state) {
                  if (state is WalletErrorState) {
                    toast(state.message);
                  }
                  if (state is InitializePaymentLoaded) {
                    InitializeEntity initializeEntity = state.initializeEntity;
                    context.push('/payment-webview', extra: initializeEntity);
                  }
                },
                builder: (context, state) {
                  late Widget subBtn;
                  if (state is InitializePaymentLoading) {
                    subBtn = const TaxiAlongLoading();
                  } else if (state is WalletErrorState) {
                    subBtn = Text(
                      "Fund Wallet (Try Again)",
                      style: GoogleFonts.robotoFlex(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: white,
                      ),
                    );
                  } else {
                    subBtn = Text(
                      "Fund Wallet",
                      style: GoogleFonts.robotoFlex(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: white,
                      ),
                    );
                  }

                  return Container(
                    margin: EdgeInsets.only(
                      bottom: 40.h,
                    ),
                    width: 358.w,
                    height: 60.h,
                    child: TextButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            side: const BorderSide(
                              color: primaryColor,
                            ),
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(primaryColor),
                      ),
                      child: subBtn,
                      onPressed: () =>
                          context.read<WalletBloc>().add(InitializePaymentEvent(
                                amount: amountcontroller.text,
                              )),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

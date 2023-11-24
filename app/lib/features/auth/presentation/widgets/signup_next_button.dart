import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/core/widgets/taxi_along_loading.dart';
import 'package:taxialong/features/auth/domain/entities/otp_entity.dart';
import 'package:taxialong/features/auth/domain/entities/telephone_entity.dart';
import 'package:taxialong/features/auth/presentation/bloc/auth/auth_bloc.dart';

class SignUpNextButton extends StatelessWidget {
  final String? type;
  final String? telephone;
  final bool? checked;
  final String? uuid;
  final Map<String, dynamic>? otps;
  const SignUpNextButton({
    super.key,
    this.type,
    required this.telephone,
    this.checked,
    this.otps,
    this.uuid,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.only(
            top: 40.h,
          ),
          width: 358.w,
          height: 52.h,
          child: TextButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  side: const BorderSide(
                    color: primaryColor,
                  ),
                ),
              ),
              backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
            ),
            child: state is AuthLoadingState
                ? const TaxiAlongLoading()
                : Text(
                    "Next",
                    style: GoogleFonts.robotoFlex(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: white,
                    ),
                  ),
            onPressed: () {
              if (type == "create_account") {
                if (checked == true) {
                  if (telephone != null) {
                    context
                        .read<AuthBloc>()
                        .add(RegisterEvent(telephone: telephone!));
                  } else {
                    toast("Provide your telephone number");
                  }
                } else {
                  toast("You need to agree to our terms of use");
                }

                // register state
                if (state is RegisterState) {
                  TelephoneEntity telephoneEntity =
                      state.telephoneEntity; // verify your OTP
                  if (telephoneEntity.status) {
                    context.push(
                      "/verify-otp",
                      extra: telephoneEntity,
                    );
                  }

                  toast(telephoneEntity.message);
                }
              }

              if (type == "otp") {
                String otp = otps!.values.join();
                if (otp.isNotEmpty) {
                  if (telephone != null || uuid != null) {
                    context.read<AuthBloc>().add(VerifyOTPEvent(
                        otp: otp, telephone: telephone!, uuid: uuid!));
                  } else {
                    toast("There was been an error");
                  }
                } else {
                  toast("Enter your verification code sent to your mobile");
                }

                // verify state
                if (state is VerifyOTPState) {
                  OTPEntity otpEntity = state.otpEntity;
                  if (otpEntity.status) {
                    context.push(
                      "/create-account",
                      extra: otpEntity,
                    );
                  }

                  toast(otpEntity.message);
                }
              }

              // error state
              if (state is ErrorAuthState) {
                String message = state.message;

                toast(message);
              }
            },
          ),
        );
      },
    );
  }
}

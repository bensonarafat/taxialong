import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/core/widgets/taxi_along_loading.dart';
import 'package:taxialong/features/auth/domain/entities/auth_entity.dart';
import 'package:taxialong/features/auth/domain/entities/otp_entity.dart';
import 'package:taxialong/features/auth/presentation/bloc/auth/auth_bloc.dart';

class SignUpNextButton extends StatelessWidget {
  final String? telephone;
  final bool? checked;
  final String? uuid;
  final Map<String, dynamic>? otps;
  final String? handler;
  const SignUpNextButton({
    super.key,
    required this.telephone,
    this.checked,
    this.otps,
    this.uuid,
    this.handler,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
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
              String otp = otps!.values.join();

              if (otp.isNotEmpty) {
                if (telephone != null || uuid != null) {
                  context.read<AuthBloc>().add(VerifyOTPEvent(
                        otp: otp,
                        telephone: telephone!,
                        uuid: uuid!,
                        handler: handler!,
                      ));
                } else {
                  toast("There was been an error");
                }
              } else {
                toast("Enter your verification code sent to your mobile");
              }
            },
          ),
        );
      },
      listener: (context, state) {
        // error state
        if (state is ErrorAuthState) {
          String message = state.message;

          toast(message);
        }

        // auth state
        if (state is LoginState) {
          AuthEntity authEntity = state.authEntity;
          if (authEntity.status) {
            context.go(
              "/nav",
              extra: authEntity,
            );
          }

          toast(authEntity.message);
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
      },
    );
  }
}

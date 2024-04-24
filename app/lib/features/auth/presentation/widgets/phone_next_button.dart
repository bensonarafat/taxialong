import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/core/widgets/taxi_along_loading.dart';
import 'package:taxialong/features/auth/domain/entities/telephone_entity.dart';
import 'package:taxialong/features/auth/presentation/bloc/auth/auth_bloc.dart';

class PhoneNextButton extends StatelessWidget {
  final String? telephone;
  final bool checked;
  final String? uuid;
  final Map<String, dynamic>? otps;
  final String? handler;
  const PhoneNextButton({
    super.key,
    required this.telephone,
    this.checked = true,
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
              if (checked == true) {
                if (telephone != null && telephone != '+234') {
                  context
                      .read<AuthBloc>()
                      .add(PhoneNumberEvent(telephone: telephone!));
                } else {
                  toast("Provide your telephone number");
                }
              } else {
                toast("You need to agree to our terms of use");
              }
            },
          ),
        );
      },
      // listener
      listener: (context, state) {
        //error
        if (state is ErrorAuthState) {
          String message = state.message;

          toast(message);
        }
        // nav
        if (state is PhoneNumberState) {
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
      },
    );
  }
}

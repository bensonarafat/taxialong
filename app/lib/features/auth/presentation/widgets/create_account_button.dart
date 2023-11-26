import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/core/widgets/taxi_along_loading.dart';
import 'package:taxialong/features/auth/domain/entities/auth_entity.dart';
import 'package:taxialong/features/auth/domain/entities/otp_entity.dart';
import 'package:taxialong/features/auth/presentation/bloc/auth/auth_bloc.dart';

class CreateAccountButton extends StatelessWidget {
  final String firstname;
  final String lastname;
  final OTPEntity otp;
  final String email;
  const CreateAccountButton({
    super.key,
    required this.firstname,
    required this.lastname,
    required this.otp,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.only(
            top: 33.h,
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
                    "Create Account",
                    style: GoogleFonts.robotoFlex(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: white,
                    ),
                  ),
            onPressed: () {
              if (firstname == "" || lastname == "" || email == "") {
                toast("You must fill all the field");
              } else {
                if (otp.status) {
                  context.read<AuthBloc>().add(
                        CreateAccountEvent(
                          firstname: firstname,
                          lastname: lastname,
                          email: email,
                          telephone: otp.telephone,
                          uuid: otp.uuid,
                        ),
                      );
                } else {
                  toast("You must fill all the field");
                }
              }
            },
          ),
        );
      },
      listener: (context, state) {
        //error
        if (state is ErrorAuthState) {
          String message = state.message;

          toast(message);
        }
        if (state is CreateAccountState) {
          AuthEntity authEntity = state.authEntity;
          if (authEntity.status) {
            // navigate to the home/nav page
            context.go("/nav");
          } else {
            toast(authEntity.message);
          }
        }
      },
    );
  }
}

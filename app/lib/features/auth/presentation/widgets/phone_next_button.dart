import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/core/widgets/taxi_along_button.dart';
import 'package:taxialong/features/auth/domain/entities/telephone_entity.dart';
import 'package:taxialong/features/auth/presentation/bloc/login/login_bloc.dart';

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
    return BlocConsumer<LoginBloc, LoginState>(
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
      builder: (context, state) {
        bool isLoading = false;
        if (state is LoginLoadingState) {
          isLoading = true;
        }
        return TaxiAlongButton(
          loading: isLoading,
          onPressed: () {
            if (checked == true) {
              if (telephone != null && telephone != '+234') {
                context
                    .read<LoginBloc>()
                    .add(PhoneNumberEvent(telephone: telephone!));
              } else {
                toast("Provide your telephone number");
              }
            } else {
              toast("You need to agree to our terms of use");
            }
          },
          buttonText: "Next",
        );
      },
    );
  }
}

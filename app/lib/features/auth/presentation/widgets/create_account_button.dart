import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/core/widgets/taxi_along_button.dart';
import 'package:taxialong/features/auth/domain/entities/auth_entity.dart';
import 'package:taxialong/features/auth/domain/entities/otp_entity.dart';
import 'package:taxialong/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:taxialong/features/auth/presentation/bloc/login/login_bloc.dart';

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
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        //error
        if (state is ErrorAuthState) {
          String message = state.message;

          toast(message);
        }
        if (state is CreateAccountState) {
          AuthEntity authEntity = state.authEntity;
          if (authEntity.status) {
            context.read<AuthBloc>().add(AuthLoginEvent());
            // navigate to the home /nav page
            if (authEntity.role == "driver") {
              context.go("/driver-home");
            } else {
              context.go("/nav");
            }
          } else {
            toast(authEntity.message);
          }
        }
      },
      builder: (context, state) {
        bool isLoading = false;
        if (state is LoginLoadingState) {
          isLoading = true;
        } else {
          isLoading = false;
        }
        return TaxiAlongButton(
          loading: isLoading,
          onPressed: () {
            if (firstname == "" || lastname == "" || email == "") {
              toast("You must fill all the field");
            } else {
              if (otp.status) {
                context.read<LoginBloc>().add(
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
          buttonText: "Create Account",
        );
      },
    );
  }
}

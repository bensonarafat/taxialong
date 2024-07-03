import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:taxialong/core/services/get_it_services.dart';
import 'package:taxialong/core/widgets/taxi_along_input_field.dart';
import 'package:taxialong/core/widgets/taxi_along_or_text.dart';
import 'package:taxialong/core/widgets/taxi_along_social_buttons.dart';
import 'package:taxialong/features/auth/domain/entities/otp_entity.dart';
import 'package:taxialong/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:taxialong/features/auth/presentation/widgets/already_have_account.dart';
import 'package:taxialong/features/auth/presentation/widgets/create_account_button.dart';

class CreateAccount extends StatefulWidget {
  final OTPEntity otp;
  const CreateAccount({
    super.key,
    required this.otp,
  });

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  String firstname = "";
  String lastname = "";
  String email = "";
  fieldfirstname(v) {
    setState(() {
      firstname = v;
    });
  }

  fieldlastname(v) {
    setState(() {
      lastname = v;
    });
  }

  fieldemail(v) {
    setState(() {
      email = v;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => getIt<LoginBloc>(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: 8.h,
                          left: 16.w,
                        ),
                        child: Text(
                          "Create an Account",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 8.h,
                          bottom: 16.h,
                          left: 16.w,
                        ),
                        child: Text(
                          "Sign up to get started",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 48.h,
                        ),
                        child: TaxiAlongInputField(
                          onChange: fieldfirstname,
                          label: "First Name",
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 48.h,
                        ),
                        child: TaxiAlongInputField(
                          onChange: fieldlastname,
                          label: "Last Name",
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 48.h,
                        ),
                        child: TaxiAlongInputField(
                          onChange: fieldemail,
                          label: "Email Address",
                        ),
                      ),
                      Gap(16.h),
                      Center(
                        child: CreateAccountButton(
                          otp: widget.otp,
                          firstname: firstname,
                          lastname: lastname,
                          email: email,
                        ),
                      ),
                      const Center(child: OrText()),
                      const SocialButtons(),
                      Container(
                        margin: EdgeInsets.only(
                          top: 21.h,
                        ),
                        child: const AlreadyHaveAnAccount(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

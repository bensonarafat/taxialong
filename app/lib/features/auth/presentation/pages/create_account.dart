import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxialong/core/widgets/taxi_along_email_field.dart';
import 'package:taxialong/core/widgets/taxi_along_first_name_field.dart';
import 'package:taxialong/core/widgets/taxi_along_last_name_field.dart';
import 'package:taxialong/core/widgets/taxi_along_or_text.dart';
import 'package:taxialong/core/widgets/taxi_along_social_buttons.dart';
import 'package:taxialong/features/auth/domain/entities/otp_entity.dart';
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
    return Scaffold(
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
                      child: FirstNameField(
                        callback: fieldfirstname,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 8.h,
                      ),
                      child: LastNameField(
                        callback: fieldlastname,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 8.h,
                      ),
                      child: EmailField(
                        callback: fieldemail,
                      ),
                    ),
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
    );
  }
}

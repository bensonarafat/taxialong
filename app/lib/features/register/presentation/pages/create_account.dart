import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/core/widgets/taxi_along_email_field.dart';
import 'package:taxialong/core/widgets/taxi_along_first_name_field.dart';
import 'package:taxialong/core/widgets/taxi_along_last_name_field.dart';
import 'package:taxialong/core/widgets/taxi_along_or_text.dart';
import 'package:taxialong/core/widgets/taxi_along_social_buttons.dart';
import 'package:taxialong/features/register/presentation/widgets/already_have_account.dart';
import 'package:taxialong/features/register/presentation/widgets/create_account_button.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    firstnameController.dispose();
    lastnameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.chevron_left,
            weight: 24.sp,
          ),
        ),
      ),
      backgroundColor: dark,
      body: Stack(
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
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 24.sp,
                      color: const Color(
                        0xfff3f3f3,
                      ),
                    ),
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
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                      color: const Color(
                        0xfff3f3f3,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 48.h,
                  ),
                  child: FirstNameField(
                    firstnameController: firstnameController,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 8.h,
                  ),
                  child: LastNameField(
                    lastnameController: lastnameController,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 8.h,
                  ),
                  child: EmailField(
                    emailController: emailController,
                  ),
                ),
                const Center(child: CreateAccountButton()),
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
    );
  }
}

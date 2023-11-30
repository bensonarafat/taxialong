import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:taxialong/core/utils/colors.dart';

class ProfileTelephone extends StatefulWidget {
  final Function userNumberFunc;
  final TextEditingController telephoneController;
  const ProfileTelephone(
      {super.key,
      required this.userNumberFunc,
      required this.telephoneController});

  @override
  State<ProfileTelephone> createState() => _ProfileTelephoneState();
}

class _ProfileTelephoneState extends State<ProfileTelephone> {
  void updateTelephone(String? number) {
    setState(() {
      widget.userNumberFunc(number);
    });
  }

  @override
  Widget build(BuildContext context) {
    PhoneNumber number = PhoneNumber(isoCode: 'NG');
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Telephone', style: Theme.of(context).textTheme.titleSmall),
              Gap(4.h),
              InternationalPhoneNumberInput(
                textFieldController: widget.telephoneController,
                inputDecoration: InputDecoration(
                  hintText: "",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? white
                          : dark,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? white
                          : dark,
                    ),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? white
                          : dark,
                    ),
                  ),
                  hintStyle: Theme.of(context).textTheme.bodyLarge,
                ),
                onInputChanged: (PhoneNumber number) {
                  updateTelephone(number.phoneNumber);
                },
                onInputValidated: (bool value) {},
                selectorConfig: const SelectorConfig(
                  selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                ),
                ignoreBlank: false,
                autoValidateMode: AutovalidateMode.disabled,
                selectorTextStyle: Theme.of(context).textTheme.bodyLarge,
                initialValue: number,
                formatInput: true,
                keyboardType: const TextInputType.numberWithOptions(
                  signed: true,
                  decimal: true,
                ),
                inputBorder: InputBorder.none,
                onSaved: (PhoneNumber number) {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}

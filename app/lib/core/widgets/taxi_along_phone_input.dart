import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxialong/core/utils/colors.dart';

class PhoneNumberInput extends StatefulWidget {
  final Function userNumberFunc;
  const PhoneNumberInput({
    super.key,
    required this.userNumberFunc,
  });

  @override
  State<PhoneNumberInput> createState() => _PhoneNumberInputState();
}

class _PhoneNumberInputState extends State<PhoneNumberInput> {
  void updateTelephone(String? number) {
    setState(() {
      widget.userNumberFunc(number);
    });
  }

  String? phoneNumber;
  @override
  Widget build(BuildContext context) {
    PhoneNumber number = PhoneNumber(isoCode: 'NG');

    return Container(
      padding: EdgeInsets.all(
        5.w,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color:
              Theme.of(context).brightness == Brightness.light ? dark : white,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      width: 358.w,
      child: InternationalPhoneNumberInput(
        inputDecoration: InputDecoration(
          hintText: "",
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
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
    );
  }
}

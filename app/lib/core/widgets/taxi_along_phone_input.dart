import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxialong/core/utils/colors.dart';

class PhoneNumberInput extends StatelessWidget {
  const PhoneNumberInput({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    PhoneNumber number = PhoneNumber(isoCode: 'NG');
    return Container(
      padding: EdgeInsets.all(
        5.w,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: white,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      width: 358.w,
      child: InternationalPhoneNumberInput(
        inputDecoration: const InputDecoration(
          hintText: "",
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintStyle: TextStyle(
            color: white,
          ),
        ),
        onInputChanged: (PhoneNumber number) {},
        onInputValidated: (bool value) {},
        selectorConfig: const SelectorConfig(
          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
        ),
        ignoreBlank: false,
        autoValidateMode: AutovalidateMode.disabled,
        selectorTextStyle: const TextStyle(
          color: Colors.white,
        ),
        initialValue: number,
        textFieldController: controller,
        formatInput: true,
        keyboardType:
            const TextInputType.numberWithOptions(signed: true, decimal: true),
        inputBorder: InputBorder.none,
        onSaved: (PhoneNumber number) {},
      ),
    );
  }
}

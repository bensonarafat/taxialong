import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class TaxiAlongInputField extends StatefulWidget {
  final Function(String input) onChange;
  final String label;
  final String? hint;
  final TextEditingController? controller;
  const TaxiAlongInputField({
    super.key,
    required this.onChange,
    required this.label,
    this.hint,
    this.controller,
  });

  @override
  State<TaxiAlongInputField> createState() => _TaxiAlongInputFieldState();
}

class _TaxiAlongInputFieldState extends State<TaxiAlongInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 16.w,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Gap(4.h),
          TextFormField(
            controller: widget.controller,
            onChanged: widget.onChange,
            decoration: InputDecoration(
              helperText: widget.hint,
              counterText: '',
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxialong/core/utils/colors.dart';

class Withdraw extends StatelessWidget {
  const Withdraw({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Withdraw Fund',
        ),
        leading: GestureDetector(
          onTap: () {
            context.pop();
          },
          child: IconTheme(
            data: Theme.of(context).iconTheme,
            child: const Icon(
              Icons.keyboard_arrow_left,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16.w),
                  child: SizedBox(
                    width: 358.w,
                    child: TextFormField(
                      maxLength: 5,
                      autofocus: true,
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                            fontWeight: FontWeight.w900,
                          ),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "0",
                        hintStyle:
                            Theme.of(context).textTheme.displayLarge!.copyWith(
                                  fontWeight: FontWeight.w900,
                                ),
                        prefix: Container(
                          padding: EdgeInsets.only(right: 8.w),
                          child: Text(
                            "₦",
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(
                                  fontWeight: FontWeight.w900,
                                ),
                          ),
                        ),
                        suffix: Text(
                          ".00",
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(
                                fontWeight: FontWeight.w900,
                              ),
                        ),
                        counterText: '',
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(8.w),
                  child: DottedBorder(
                    strokeWidth: 2,
                    dashPattern: const [5, 3, 1],
                    padding: EdgeInsets.all(8.w),
                    color: Brightness.dark == Theme.of(context).brightness
                        ? white
                        : dark,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            child: Icon(
                              CupertinoIcons.pencil_ellipsis_rectangle,
                              size: 25.w,
                            ),
                          ),
                        ),
                        Text(
                          "Bank: GTBank of Nigeria",
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Gap(16.h),
                        Text(
                          "Name: Benson Arafat",
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Gap(16.h),
                        Text(
                          "Account Number: 0909398484",
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8.w),
                  child: DottedBorder(
                    color: primaryColor,
                    strokeWidth: 2,
                    dashPattern: const [5, 3, 1],
                    padding: EdgeInsets.all(16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.add,
                          size: 25.w,
                        ),
                        Gap(8.w),
                        Text(
                          "Add Bank Details",
                          style:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp,
                                  ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: 40.h),
              width: 358.w,
              height: 52.h,
              child: TextButton(
                style: ButtonStyle(
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      side: const BorderSide(
                        color: primaryColor,
                      ),
                    ),
                  ),
                  backgroundColor: WidgetStateProperty.all<Color>(primaryColor),
                ),
                child: Text(
                  "Withdraw",
                  style: GoogleFonts.robotoFlex(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: white,
                  ),
                ),
                onPressed: () async {},
              ),
            ),
          )
        ],
      ),
    );
  }
}

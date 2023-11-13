import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxialong/core/utils/colors.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: const Text(
          'Privacy Policy',
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: IconTheme(
            data: Theme.of(context).iconTheme,
            child: const Icon(
              Icons.keyboard_arrow_left,
            ),
          ),
        ),
      ),
      body: Stack(children: [
        Align(
          alignment: Alignment.topLeft,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16.r),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Privacy Policy',
                      style: GoogleFonts.robotoFlex(
                        color: secondaryColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Gap(16.h),
                    Text(
                      'This is a dummy copy, it is not meant to be read. it has been placed here solely to demonstrate the look and feel of of finished typeset text. Only for show. He who searches for meaning here will be solely disappointed. These words are here to provide the reader with a basic impression of how actual text will appear in its final presentation. Think of them merely as actors on a Paper stage. in a performance devoid of content yet rich in form. That being the case there is really no point in your continuing to read them.',
                      style: GoogleFonts.robotoFlex(
                        color: const Color(0xFF6E6E6E),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Gap(16.h),
                    Text(
                      'This is a dummy copy, it is not meant to be read. it has been placed here solely to demonstrate the look and feel of of finished typeset text. Only for show. He who searches for meaning here will be solely disappointed. These words are here to provide the reader with a basic impression of how actual text will appear in its final presentation. Think of them merely as actors on a Paper stage. in a performance devoid of content yet rich in form. That being the case there is really no point in your continuing to read them.',
                      style: GoogleFonts.robotoFlex(
                        color: const Color(0xFF6E6E6E),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

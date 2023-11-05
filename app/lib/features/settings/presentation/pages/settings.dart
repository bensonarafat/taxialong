import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxialong/core/constants/assets.dart';
import 'package:taxialong/core/utils/colors.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Settings',
          style: GoogleFonts.robotoFlex(
            color: white,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.keyboard_arrow_left,
            color: white,
          ),
        ),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  leading: SvgPicture.asset(notificationIcon),
                  trailing: SvgPicture.asset(toggleOn),
                  subtitle: Text(
                    'Currently On',
                    style: GoogleFonts.robotoFlex(
                      color: white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  title: Text(
                    'Notifications',
                    style: GoogleFonts.robotoFlex(
                      color: white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

                //

                ListTile(
                  leading: SvgPicture.asset(globe),
                  subtitle: Text(
                    'EN (UK)',
                    style: GoogleFonts.robotoFlex(
                      color: white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  title: Text(
                    'Language',
                    style: GoogleFonts.robotoFlex(
                      color: white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

                ListTile(
                  leading: SvgPicture.asset(starBorder),
                  subtitle: Text(
                    'Rate us',
                    style: GoogleFonts.robotoFlex(
                      color: white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  title: Text(
                    'Enjoying the app?',
                    style: GoogleFonts.robotoFlex(
                      color: white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(
                bottom: 52.h,
              ),
              child: Text(
                'Delete Account',
                style: GoogleFonts.robotoFlex(
                  color: const Color(0xFFFF7171),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

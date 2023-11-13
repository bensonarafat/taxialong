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
        title: const Text(
          'Settings',
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
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  leading: SvgPicture.asset(
                    notificationIcon,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).brightness == Brightness.dark
                          ? white
                          : dark,
                      BlendMode.srcATop,
                    ),
                  ),
                  trailing: SvgPicture.asset(toggleOn),
                  subtitle: Text(
                    'Currently On',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  title: Text(
                    'Notifications',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),

                //

                ListTile(
                  leading: SvgPicture.asset(
                    globe,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).brightness == Brightness.dark
                          ? white
                          : dark,
                      BlendMode.srcATop,
                    ),
                  ),
                  subtitle: Text(
                    'EN (UK)',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  title: Text(
                    'Language',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),

                ListTile(
                  leading: SvgPicture.asset(
                    starBorder,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).brightness == Brightness.dark
                          ? white
                          : dark,
                      BlendMode.srcATop,
                    ),
                  ),
                  subtitle: Text(
                    'Rate us',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  title: Text(
                    'Enjoying the app?',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
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

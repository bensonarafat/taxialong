import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxialong/core/constants/assets.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/features/about/presentation/pages/about.dart';
import 'package:taxialong/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:taxialong/features/documents/presentation/pages/documents.dart';
import 'package:taxialong/features/driver/presentation/pages/become_driver.dart';
import 'package:taxialong/features/help_center/presentation/pages/help_center.dart';
import 'package:taxialong/features/notification/presentation/pages/notification.dart';
import 'package:taxialong/features/profile/presentation/pages/profile.dart';
import 'package:taxialong/features/referral/presentation/pages/referral.dart';
import 'package:taxialong/features/settings/presentation/pages/settings.dart';
import 'package:taxialong/features/trip_history/presentation/pages/trip_history.dart';

class TaxiAlongDrawer extends StatelessWidget {
  const TaxiAlongDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
      ),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(bottom: 50.h),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 40.h),
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 0.50.w,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? white
                          : dark,
                    ),
                  ),
                ),
                height: 222.h,
                width: double.infinity,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(16.w),
                      alignment: Alignment.topRight,
                      child: Image.asset(
                        darkModeIcon,
                        width: 24.w,
                        height: 24.h,
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 52.w,
                          height: 52.h,
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            image: const DecorationImage(
                              image: AssetImage(user),
                              fit: BoxFit.fill,
                            ),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 1.w,
                                color: const Color(0xFFA0A2A9),
                              ),
                              borderRadius: BorderRadius.circular(100.r),
                            ),
                          ),
                        ),
                        Gap(8.h),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Lucy Edwin',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                    fontSize: 20.sp,
                                  ),
                            ),
                            Gap(8.h),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.star,
                                  color: const Color(0xffFEDA15),
                                  size: 24.w,
                                ),
                                Gap(8.h),
                                Text(
                                  '5.0',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
                                        fontSize: 16.sp,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),

              // others
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const TripHistory()));
                    },
                    title: Text(
                      'Ride History',
                      style: Theme.of(context).listTileTheme.titleTextStyle,
                    ),
                    leading: SvgPicture.asset(
                      carSVG,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).brightness == Brightness.dark
                            ? white
                            : dark,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),

                  //

                  ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const Profile()));
                    },
                    title: Text(
                      'Profile',
                      style: Theme.of(context).listTileTheme.titleTextStyle,
                    ),
                    leading: SvgPicture.asset(
                      profileSVG,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).brightness == Brightness.dark
                            ? white
                            : dark,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),

                  ListTile(
                    title: Text(
                      'Wallet',
                      style: Theme.of(context).listTileTheme.titleTextStyle,
                    ),
                    leading: SvgPicture.asset(
                      paymentSVG,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).brightness == Brightness.dark
                            ? white
                            : dark,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),

                  ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const TaxiAlongNotification()));
                    },
                    title: Text(
                      'Notifications',
                      style: Theme.of(context).listTileTheme.titleTextStyle,
                    ),
                    leading: SvgPicture.asset(
                      notificationSVG,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).brightness == Brightness.dark
                            ? white
                            : dark,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),

                  ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const Referral()));
                    },
                    title: Text(
                      'Referral',
                      style: Theme.of(context).listTileTheme.titleTextStyle,
                    ),
                    leading: SvgPicture.asset(
                      referralSVG,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).brightness == Brightness.dark
                            ? white
                            : dark,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),

                  ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const Documents()));
                    },
                    title: Text(
                      'Manage Documents',
                      style: Theme.of(context).listTileTheme.titleTextStyle,
                    ),
                    leading: SvgPicture.asset(
                      manageDocuments,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).brightness == Brightness.dark
                            ? white
                            : dark,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const BecomeDriver()));
                    },
                    title: Text(
                      'Become a Driver',
                      style: Theme.of(context).listTileTheme.titleTextStyle,
                    ),
                    leading: SvgPicture.asset(
                      truckdriverSVG,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).brightness == Brightness.dark
                            ? white
                            : dark,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),

                  ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const HelpCenter()));
                    },
                    title: Text(
                      'Help',
                      style: Theme.of(context).listTileTheme.titleTextStyle,
                    ),
                    leading: SvgPicture.asset(
                      helpSVG,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).brightness == Brightness.dark
                            ? white
                            : dark,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),

                  ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const Settings()));
                    },
                    title: Text(
                      'Settings',
                      style: Theme.of(context).listTileTheme.titleTextStyle,
                    ),
                    leading: SvgPicture.asset(
                      settingsSVG,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).brightness == Brightness.dark
                            ? white
                            : dark,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),

                  ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const AboutPage()));
                    },
                    title: Text(
                      'About',
                      style: Theme.of(context).listTileTheme.titleTextStyle,
                    ),
                    leading: SvgPicture.asset(
                      aboutSVG,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).brightness == Brightness.dark
                            ? white
                            : dark,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),

                  BlocListener<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is UnAuthenticatedState) {
                        context.go("/getstarted");
                      }
                      //error
                      if (state is ErrorAuthState) {
                        toast(state.message);
                      }
                    },
                    child: ListTile(
                      onTap: () {
                        context.read<AuthBloc>().add(LogoutEvent());
                      },
                      title: Text(
                        'Logout',
                        style: GoogleFonts.robotoFlex(
                          color: primaryColor,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      leading: SvgPicture.asset(logoutSVG),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

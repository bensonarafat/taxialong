import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxialong/core/bloc/settings/settings_bloc.dart';
import 'package:taxialong/core/constants/assets.dart';
import 'package:taxialong/core/constants/constants.dart';
import 'package:taxialong/core/services/secure_storage.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/core/widgets/taxi_along_cache_network_image.dart';
import 'package:taxialong/core/data/models/user_model.dart';
import 'package:taxialong/features/auth/presentation/bloc/auth/auth_bloc.dart';

class TaxiAlongDrawer extends StatefulWidget {
  const TaxiAlongDrawer({super.key});

  @override
  State<TaxiAlongDrawer> createState() => _TaxiAlongDrawerState();
}

class _TaxiAlongDrawerState extends State<TaxiAlongDrawer> {
  SecureStorage secureStorage = SecureStorage();
  bool driverMode = false;
  int documentCount = 0;
  String username = "";
  String avatar = imageplaceholder;
  int rating = 0;
  String role = 'rider';
  late CancelFunc cancel;
  @override
  void initState() {
    drawerAction();
    super.initState();
  }

  drawerAction() {
    _getUserData();
  }

  _getUserData() async {
    UserModel? usermodel = await secureStorage.getUserData();
    setState(() {
      username = "${usermodel?.firstname} ${usermodel?.lastname}";
      avatar = "${usermodel?.avatar}";
      rating = usermodel == null ? 0 : int.parse(usermodel.rating);
      role = usermodel == null ? 'rider' : usermodel.role;
      driverMode = role == "driver" ? true : false;
      documentCount =
          usermodel == null ? 0 : int.parse(usermodel.documentCount ?? '0');
    });
  }

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
                        TaxiAlongCachedNetworkImage(
                          path: avatar,
                          width: 52,
                          fit: BoxFit.fill,
                          height: 52,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1.w,
                              color: const Color(0xFFA0A2A9),
                            ),
                            borderRadius: BorderRadius.circular(100.r),
                          ),
                        ),
                        Gap(8.h),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              username,
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
                                  '$rating.0',
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
                    onTap: () async {
                      await context.push('/ride-history');
                      drawerAction();
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
                    onTap: () async {
                      await context.push("/profile");
                      drawerAction();
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
                  driverMode
                      ? ListTile(
                          onTap: () {
                            context.push("/wallet");
                          },
                          title: Text(
                            'Wallet',
                            style:
                                Theme.of(context).listTileTheme.titleTextStyle,
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
                        )
                      : Container(),

                  driverMode
                      ? ListTile(
                          onTap: () async {
                            context.push("/notification");
                            drawerAction();
                          },
                          title: Text(
                            'Notifications',
                            style:
                                Theme.of(context).listTileTheme.titleTextStyle,
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
                        )
                      : Container(),

                  ListTile(
                    onTap: () async {
                      await context.push("/referral");
                      drawerAction();
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

                  driverMode
                      ? ListTile(
                          onTap: () async {
                            await context.push("/documents");
                            drawerAction();
                          },
                          title: Text(
                            'Manage Documents',
                            style:
                                Theme.of(context).listTileTheme.titleTextStyle,
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
                        )
                      : Container(),
                  // if the document count is 4, that means they have complete their driver registration
                  documentCount == 4
                      ? BlocListener<SettingsBloc, SettingsState>(
                          listener: (context, state) {
                            if (state is SettingsSwitchLoadingState) {
                              // cancel = BotToast.showLoading();
                            }
                            if (state is SettingsSwitchedState) {
                              // cancel();

                              if (role == "driver") {
                                context.go("/nav");
                              } else {
                                context.go("/driver-home");
                              }
                            }

                            if (state is SettingErrorState) {
                              // print("error");
                              toast(state.message);
                            }
                          },
                          child: Builder(builder: (context) {
                            return ListTile(
                              onTap: () {
                                context.pop();
                                context
                                    .read<SettingsBloc>()
                                    .add(SettingsSwitchAccountEvent());
                              },
                              title: Text(
                                role == "driver"
                                    ? "Passenger Mode"
                                    : 'Driver Mode',
                                style: Theme.of(context)
                                    .listTileTheme
                                    .titleTextStyle,
                              ),
                              leading: SvgPicture.asset(
                                personMode,
                                colorFilter: ColorFilter.mode(
                                  Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? white
                                      : dark,
                                  BlendMode.srcIn,
                                ),
                              ),
                            );
                          }),
                        )
                      : Container(),
                  role == 'rider' && documentCount != 4
                      ? ListTile(
                          onTap: () async {
                            await context.push("/become-driver");
                            drawerAction();
                          },
                          title: Text(
                            'Become a Driver',
                            style:
                                Theme.of(context).listTileTheme.titleTextStyle,
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
                        )
                      : Container(),

                  ListTile(
                    onTap: () async {
                      context.push("/help-center");
                      drawerAction();
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
                    onTap: () async {
                      await context.push("/settings");
                      drawerAction();
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
                    onTap: () => context.push("/about"),
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
                      if (state is AuthenticatedState) {
                        if (!state.isLogin) {
                          context.go("/getstarted");
                        }
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

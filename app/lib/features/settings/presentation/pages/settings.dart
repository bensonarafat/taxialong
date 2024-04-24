import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxialong/core/bloc/settings/settings_bloc.dart';
import 'package:taxialong/core/constants/assets.dart';
import 'package:taxialong/core/data/models/user_model.dart';
import 'package:taxialong/core/services/secure_storage.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/core/utils/helpers.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  SecureStorage secureStorage = SecureStorage();
  String role = 'rider';
  String currentRole = "rider";
  late CancelFunc cancel;
  int documentCount = 0;
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
      currentRole = usermodel == null ? 'rider' : usermodel.role;
      if (currentRole == "driver") {
        role = "Rider";
      } else {
        role = "Driver";
      }
      documentCount =
          usermodel == null ? 0 : int.parse(usermodel.documentCount ?? '0');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
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
            alignment: Alignment.topLeft,
            child: BlocListener<SettingsBloc, SettingsState>(
              listener: (context, state) {
                if (state is SettingErrorState) {
                  toast(state.message);
                }
                if (state is SettingsSwitchLoadingState) {
                  cancel = BotToast.showLoading();
                }
                if (state is SettingsSwitchedState) {
                  cancel();
                  if (currentRole == "driver") {
                    context.go("/nav");
                  } else {
                    context.go("/driver-home");
                  }
                }
              },
              child: Builder(builder: (context) {
                return ListView(
                  shrinkWrap: true,
                  children: [
                    //
                    documentCount == 4
                        ? ListTile(
                            onTap: () {
                              context
                                  .read<SettingsBloc>()
                                  .add(SettingsSwitchAccountEvent());
                            },
                            leading: SvgPicture.asset(
                              personMode,
                              width: 24.w,
                              height: 24.h,
                              colorFilter: ColorFilter.mode(
                                Theme.of(context).brightness == Brightness.dark
                                    ? white
                                    : dark,
                                BlendMode.srcATop,
                              ),
                            ),
                            subtitle: Text(
                              'You are currently a $currentRole',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            title: Text(
                              'Switch to $role',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          )
                        : Container(),
                    //
                    ListTile(
                      onTap: () {},
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
                );
              }),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Builder(builder: (context) {
              return GestureDetector(
                onTap: () {},
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
              );
            }),
          )
        ],
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxialong/core/constants/assets.dart';
import 'package:taxialong/core/constants/constants.dart';
import 'package:taxialong/core/services/get_it_services.dart';
import 'package:taxialong/core/services/secure_storage.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/core/widgets/taxi_along_cache_network_image.dart';
import 'package:taxialong/features/auth/data/models/user_model.dart';
import 'package:taxialong/features/profile/presentation/bloc/profile/profile_bloc.dart';
import 'package:taxialong/features/profile/presentation/widgets/profile_email.dart';
import 'package:taxialong/features/profile/presentation/widgets/profile_first_name.dart';
import 'package:taxialong/features/profile/presentation/widgets/profile_last_name.dart';
import 'package:taxialong/features/profile/presentation/widgets/profile_logout.dart';
import 'package:taxialong/features/profile/presentation/widgets/profile_telephone.dart';
import 'package:taxialong/features/profile/presentation/widgets/profile_update_button.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController telephoneController = TextEditingController();
  SecureStorage secureStorage = SecureStorage();
  String firstname = "";
  String lastname = "";
  String telephone = "";
  String email = "";
  int rating = 0;
  String avatar = imageplaceholder;
  File? userAvatar;

  String? phoneNumber;
  void userNumberFunc(String? number) {
    setState(() {
      phoneNumber = number;
    });
  }

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  _getUserData() async {
    UserModel? usermodel = await secureStorage.getUserData();
    setState(() {
      firstname = "${usermodel?.firstname}";
      lastname = "${usermodel?.lastname}";
      avatar = "${usermodel?.avatar}";
      email = "${usermodel?.email}";
      telephone = "${usermodel?.telephone}";

      firstnameController.text = firstname;
      lastnameController.text = lastname;
      emailController.text = email;
      telephoneController.text = extractPhoneNumber(telephone);
      rating = usermodel == null ? 0 : int.parse(usermodel.rating);
    });
  }

  Future<XFile?> openImagePicker() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        userAvatar = File(image.path);
      });
    }
    return image;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>(
      create: (BuildContext context) => getIt<ProfileBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Profile',
          ),
          leading: GestureDetector(
            onTap: () => context.pop(),
            child: IconTheme(
              data: Theme.of(context).iconTheme,
              child: const Icon(
                Icons.keyboard_arrow_left,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Gap(32.h),
              Center(
                child: SizedBox(
                  width: 143.w,
                  height: 145.h,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 7.w,
                        top: 7.h,
                        child: userAvatar != null
                            ? Container(
                                width: 129.w,
                                height: 131.h,
                                decoration: ShapeDecoration(
                                  shape: const OvalBorder(),
                                  image: DecorationImage(
                                      image: FileImage(userAvatar!),
                                      fit: BoxFit.fill),
                                ),
                              )
                            : TaxiAlongCachedNetworkImage(
                                path: avatar,
                                width: 129,
                                height: 131,
                                shape: const OvalBorder(),
                              ),
                      ),
                      Builder(builder: (context) {
                        return Positioned(
                          left: 80.w,
                          top: 80.h,
                          child: GestureDetector(
                            onTap: () {
                              openImagePicker().then((value) {
                                if (value != null) {
                                  context.read<ProfileBloc>().add(
                                        ProfileUpdateImageEvent(
                                          path: value.path,
                                        ),
                                      );
                                } else {
                                  setState(() {
                                    userAvatar = null;
                                  });
                                }
                              });
                            },
                            child: SizedBox(
                              width: 60.w,
                              height: 60.h,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 11.w,
                                    top: 12.37.h,
                                    child: SvgPicture.asset(
                                      cameraSVG,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
              Gap(16.h),
              rating == 0
                  ? Container()
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              for (int i = 0; i < rating; i++)
                                const Icon(
                                  Icons.star,
                                  color: Color(0xffF28A1A),
                                ),
                            ],
                          ),
                          Gap(4.h),
                          Text(
                            '$rating.0',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.robotoFlex(
                              color: primaryColor,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
              Gap(16.h),
              Container(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileFirstName(firstnameController: firstnameController),
                    Gap(16.h),
                    ProfileLastName(lastnameController: lastnameController),
                    Gap(16.h),
                    ProfileTelephone(
                        userNumberFunc: userNumberFunc,
                        telephoneController: telephoneController),
                    Gap(16.h),
                    ProfileEmail(emailController: emailController),
                    Gap(16.h),
                    UpdateProfileButton(
                      firstname: firstnameController.text,
                      lastname: lastnameController.text,
                      email: emailController.text,
                      telephone: telephoneController.text,
                    ),
                    Gap(143.h),
                    const ProfileLogout(),
                    Gap(37.h),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

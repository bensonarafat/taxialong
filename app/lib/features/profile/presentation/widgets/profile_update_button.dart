import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/core/widgets/taxi_along_loading.dart';
import 'package:taxialong/features/profile/domain/entities/profile_entity.dart';
import 'package:taxialong/features/profile/domain/entities/profile_photo_entity.dart';
import 'package:taxialong/features/profile/presentation/bloc/profile/profile_bloc.dart';

class UpdateProfileButton extends StatelessWidget {
  final String firstname;
  final String lastname;
  final String email;
  final String telephone;
  const UpdateProfileButton({
    super.key,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.telephone,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileErrorState) {
          toast(state.message);
        }
        if (state is ProfileUpdateState) {
          ProfileEntity profileEntity = state.profileEntity;
          toast(profileEntity.message);
        }

        if (state is ProfilePhotoUpdateState) {
          ProfilePhototEntity profileEntity = state.photoEntity;
          toast(profileEntity.message);
        }
      },
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.only(
            top: 40.h,
          ),
          width: 358.w,
          height: 52.h,
          child: TextButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  side: const BorderSide(
                    color: primaryColor,
                  ),
                ),
              ),
              backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
            ),
            child: state is ProfileLoadingState
                ? const TaxiAlongLoading()
                : Text(
                    "Update Profile",
                    style: GoogleFonts.robotoFlex(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: white,
                    ),
                  ),
            onPressed: () async {
              if (state is ProfileLoadingState) {
              } else {
                context.read<ProfileBloc>().add(
                      ProfileUpdateEvent(
                        firstname: firstname,
                        lastname: lastname,
                        telephone: telephone,
                        email: email,
                      ),
                    );
              }
            },
          ),
        );
      },
    );
  }
}

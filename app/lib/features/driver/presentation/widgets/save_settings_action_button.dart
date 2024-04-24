import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxialong/core/bloc/settings/settings_bloc.dart';
import 'package:taxialong/core/domain/entities/settings_update_entity.dart';
import 'package:taxialong/core/domain/usecases/update_settings_usecase.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/core/widgets/taxi_along_loading.dart';

class SaveSettingsActionButton extends StatelessWidget {
  final SettingsParams params;
  const SaveSettingsActionButton({
    super.key,
    required this.params,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (params.pointa == null) {
          toast("Your starting location is required");
        } else if (params.pointb == null) {
          toast("Your ending location is required");
        } else if (params.selectedClass == null) {
          toast("You need to select at least one class type");
        } else if (params.paymentMethod.isEmpty) {
          toast("Oops, there must be an error");
        } else {
          context.read<SettingsBloc>().add(
                UpdateSettingsEvent(
                  pointa: params.pointa,
                  pointb: params.pointb,
                  selectedClass: params.selectedClass,
                  paymentMethod: params.paymentMethod,
                ),
              );
        }
      },
      child: BlocConsumer<SettingsBloc, SettingsState>(
        listener: (context, state) {
          if (state is SettingErrorState) {
            toast(state.message);
          }
          if (state is SettingsUpdatedState) {
            SettingsUpdateEntity settingsUpdateEntity =
                state.settingsUpdateEntity;
            toast(settingsUpdateEntity.message);
            if (settingsUpdateEntity.status) {
              // pop out the bottomsheet if successful
              context.pop();
            }
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                Container(
                  width: 358.w,
                  height: 52.h,
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                  decoration: ShapeDecoration(
                    color: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      state is SettingsLoadingState
                          ? const TaxiAlongLoading()
                          : Text(
                              'Save',
                              style: GoogleFonts.robotoFlex(
                                color: white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

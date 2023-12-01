import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:taxialong/core/constants/assets.dart';
import 'package:taxialong/core/services/get_it_services.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/core/widgets/taxi_along_loading.dart';
import 'package:taxialong/features/documents/presentation/bloc/document_bloc.dart';
import 'package:taxialong/features/documents/presentation/widgets/driver_licence.dart';
import 'package:taxialong/features/documents/presentation/widgets/insurance.dart';
import 'package:taxialong/features/documents/presentation/widgets/national_id.dart';
import 'package:taxialong/features/documents/presentation/widgets/vehicle_registration.dart';

class UploadDocuments extends StatelessWidget {
  const UploadDocuments({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DocumentBloc>(
      create: (_) => getIt<DocumentBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'My Document',
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
        body: Container(
          padding: EdgeInsets.all(16.w),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    const DriversLicence(),
                    Gap(16.h),
                    const NationalId(),
                    Gap(16.h),
                    const VehicleRegistration(),
                    Gap(16.h),
                    const Insurance(),
                    Gap(16.h),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'All documents are required',
                        style: GoogleFonts.robotoFlex(
                          color: const Color(0xFFE81313),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: BlocConsumer<DocumentBloc, DocumentState>(
                  listener: (context, state) {
                    if (state is DocumentErrorState) {
                      toast(state.message);
                    }

                    if (state is DocumentUploadedState) {
                      documentAlert(context).show();
                    }
                  },
                  builder: (context, state) {
                    return GestureDetector(
                      onTap: () {
                        context
                            .read<DocumentBloc>()
                            .add(DocumentUploadCompleteEvent());
                      },
                      child: Container(
                        width: 254.w,
                        height: 42.h,
                        margin: EdgeInsets.only(bottom: 34.h),
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 4.h),
                        decoration: ShapeDecoration(
                          color: primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            state is DocumentLoadingState
                                ? const TaxiAlongLoading()
                                : Text(
                                    'Next',
                                    style: GoogleFonts.robotoFlex(
                                      color: white,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Alert documentAlert(BuildContext context) {
    return Alert(
        style: AlertStyle(
          alertBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
            side: const BorderSide(
              color: Color(0xFF121212),
            ),
          ),
          isCloseButton: false,
          titleStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.w500,
              ),
          descStyle: Theme.of(context).textTheme.titleSmall!,
        ),
        context: context,
        desc:
            "You have successfully registered as a Taxi Along Driver. You now have a Driver Account. Your details have been received and are being reviewed. Your information has been received and is being examined. You would be informed of the review status within the next 2 working days..",
        image: SvgPicture.asset(
          documentsCheck,
          width: 208.w,
          height: 208.h,
        ),
        buttons: [
          DialogButton(
            color: Colors.transparent,
            onPressed: () {
              Navigator.of(context).pop();
              context.push("/driver-home");
            },
            child: Container(
              width: 254.w,
              height: 42.h,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
              decoration: ShapeDecoration(
                color: primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Done',
                    style: GoogleFonts.robotoFlex(
                      color: white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          )
        ]);
  }
}

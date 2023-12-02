import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/core/widgets/taxi_along_loading.dart';
import 'package:taxialong/features/documents/presentation/bloc/document_bloc.dart';
import 'package:taxialong/features/documents/presentation/widgets/upload_bottom_sheet.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class NationalId extends StatelessWidget {
  const NationalId({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        WoltModalSheet.show<void>(
          enableDrag: true,
          context: context,
          pageListBuilder: (modalSheetContext) {
            return [
              uploadDocumentBottomSheet(
                  modalSheetContext, context, "national_id"),
            ];
          },
          modalTypeBuilder: (context) {
            final size = MediaQuery.of(context).size.width;
            if (size < 768.0) {
              return WoltModalType.bottomSheet;
            } else {
              return WoltModalType.dialog;
            }
          },
          maxDialogWidth: 560.w,
          minDialogWidth: 400.w,
          minPageHeight: 0.0,
        );
      },
      child: Container(
        width: 358.w,
        padding: EdgeInsets.all(16.w),
        decoration: ShapeDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? const Color(0xFF121212)
              : const Color(0x4CDADADA),
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1.w, color: const Color(0xFF77787B)),
            borderRadius: BorderRadius.circular(8.r),
          ),
          shadows: [
            BoxShadow(
              color: const Color(0x0C000000),
              blurRadius: 8.r,
              offset: const Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'National ID Card',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Gap(4.h),
                  Text(
                    'Upload national Id',
                    style: GoogleFonts.robotoFlex(
                      color: const Color(0xFFA0A2A9),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Gap(34.w),
            BlocBuilder<DocumentBloc, DocumentState>(
              buildWhen: (previousState, state) {
                return state is NationalIdLoadingState ||
                    state is NationalIdLoadedState;
              },
              builder: (context, state) {
                if (state is NationalIdLoadingState) {
                  return Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: ShapeDecoration(
                      color: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                    ),
                    child: const TaxiAlongLoading(),
                  );
                } else if (state is NationalIdLoadedState) {
                  return Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: ShapeDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? dark
                          : white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                    ),
                    child: Icon(
                      Icons.check,
                      color: primaryColor,
                      size: 40.r,
                    ),
                  );
                } else {
                  return Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: ShapeDecoration(
                      color: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                    ),
                    child: const Icon(
                      Icons.upload_file_rounded,
                      color: white,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

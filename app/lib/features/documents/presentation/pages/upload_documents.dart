import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxialong/core/services/get_it_services.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/features/documents/presentation/bloc/document_bloc.dart';
import 'package:taxialong/features/documents/presentation/pages/upload_documents2.dart';
import 'package:taxialong/features/documents/presentation/widgets/upload_bottom_sheet.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class UploadDocuments extends StatelessWidget {
  const UploadDocuments({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<DocumentBloc>(),
      child: Scaffold(
        key: key,
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
                    GestureDetector(
                      onTap: () {
                        WoltModalSheet.show<void>(
                          enableDrag: true,
                          context: context,
                          pageListBuilder: (modalSheetContext) {
                            return [
                              uploadDocumentBottomSheet(modalSheetContext),
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
                            side: BorderSide(
                                width: 1.w, color: const Color(0xFF77787B)),
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
                                    'Drivers Licence',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  Gap(4.h),
                                  Text(
                                    'Upload drivers licence',
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
                            Container(
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
                            ),
                          ],
                        ),
                      ),
                    ),
                    Gap(16.h),
                    Container(
                      width: 358.w,
                      padding: EdgeInsets.all(16.w),
                      decoration: ShapeDecoration(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? const Color(0xFF121212)
                            : const Color(0x4CDADADA),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              width: 1.w, color: const Color(0xFF77787B)),
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
                          Container(
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
                          ),
                        ],
                      ),
                    ),
                    Gap(16.h),
                    Container(
                      width: 358.w,
                      padding: EdgeInsets.all(16.w),
                      decoration: ShapeDecoration(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? const Color(0xFF121212)
                            : const Color(0x4CDADADA),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              width: 1.w, color: const Color(0xFF77787B)),
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
                                  'Vehicle Registration',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                Gap(4.h),
                                Text(
                                  'Upload vehicle registration',
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
                          Container(
                            width: 40.w,
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
                          ),
                        ],
                      ),
                    ),
                    Gap(16.h),
                    Container(
                      width: 358.w,
                      padding: EdgeInsets.all(16.w),
                      decoration: ShapeDecoration(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? const Color(0xFF121212)
                            : const Color(0x4CDADADA),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              width: 1.w, color: const Color(0xFF77787B)),
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
                                  'Insurance',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                Gap(4.h),
                                Text(
                                  'Upload Insurance documents',
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
                          Container(
                            width: 40.w,
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
                          ),
                        ],
                      ),
                    ),
                    Gap(16.h),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        '* These field are required',
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
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => const UploadDocuments2()));
                  },
                  child: Container(
                    width: 254.w,
                    height: 42.h,
                    margin: EdgeInsets.only(bottom: 34.h),
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

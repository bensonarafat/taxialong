import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taxialong/core/constants/assets.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/features/documents/presentation/bloc/document_bloc.dart';
import 'package:taxialong/features/documents/presentation/widgets/cancel_action_button.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

Future<XFile?> openImagePicker() async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  return image;
}

Future<XFile?> openCameraPicker() async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.camera);
  return image;
}

WoltModalSheetPage uploadDocumentBottomSheet(
  BuildContext modalSheetContext,
  BuildContext context,
  String type,
) {
  return WoltModalSheetPage.withSingleChild(
    topBarTitle: Text(
      'Select upload option',
      style: Theme.of(modalSheetContext).textTheme.titleLarge!.copyWith(
            fontSize: 20.sp,
            fontWeight: FontWeight.w400,
          ),
    ),
    hasSabGradient: false,
    stickyActionBar: const CancelUploadActionButton(),
    isTopBarLayerAlwaysVisible: true,
    child: Padding(
      padding: EdgeInsets.fromLTRB(
        16.0.w,
        16.0.h,
        16.0.w,
        150.0.h,
      ),
      child: SizedBox(
        width: 336.w,
        height: 107.h,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(modalSheetContext).pop();
                openCameraPicker().then((file) {
                  if (file != null) {
                    context.read<DocumentBloc>().add(
                          DocumentUploadEvent(
                            path: file.path,
                            type: type,
                          ),
                        );
                  }
                });
              },
              child: Container(
                width: double.infinity,
                height: 48.h,
                padding: EdgeInsets.all(4.r),
                decoration: BoxDecoration(
                  border: Border(
                    bottom:
                        BorderSide(width: 1.w, color: const Color(0xFFA0A2A9)),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      photoCamera,
                      width: 24.w,
                      height: 24.h,
                      colorFilter: ColorFilter.mode(
                        Theme.of(modalSheetContext).brightness ==
                                Brightness.dark
                            ? white
                            : dark,
                        BlendMode.srcIn,
                      ),
                    ),
                    Gap(4.w),
                    Expanded(
                      child: Text(
                        'Take a photo',
                        style: Theme.of(modalSheetContext)
                            .textTheme
                            .bodyLarge!
                            .copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Gap(16.h),
            GestureDetector(
              onTap: () {
                Navigator.of(modalSheetContext).pop();
                openImagePicker().then((file) {
                  if (file != null) {
                    context.read<DocumentBloc>().add(
                          DocumentUploadEvent(
                            path: file.path,
                            type: type,
                          ),
                        );
                  }
                });
              },
              child: Container(
                width: double.infinity,
                height: 43.h,
                padding: EdgeInsets.all(4.w),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      photoGallery,
                      width: 24.w,
                      height: 24.h,
                      colorFilter: ColorFilter.mode(
                        Theme.of(modalSheetContext).brightness ==
                                Brightness.dark
                            ? white
                            : dark,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        'Choose from gallery',
                        style: Theme.of(modalSheetContext)
                            .textTheme
                            .bodyLarge!
                            .copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

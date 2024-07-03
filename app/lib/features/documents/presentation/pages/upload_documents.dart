import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxialong/core/services/get_it_services.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/core/widgets/taxi_along_button.dart';
import 'package:taxialong/features/documents/presentation/bloc/document_bloc.dart';
import 'package:taxialong/features/documents/presentation/widgets/driver_licence.dart';
import 'package:taxialong/features/documents/presentation/widgets/national_id.dart';
import 'package:taxialong/features/documents/presentation/widgets/union_id.dart';

class UploadDocuments extends StatefulWidget {
  const UploadDocuments({super.key});

  @override
  State<UploadDocuments> createState() => _UploadDocumentsState();
}

class _UploadDocumentsState extends State<UploadDocuments> {
  int uploadedCount = 0;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<DocumentBloc>(
      create: (_) => getIt<DocumentBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Upload Document',
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
                    DriversLicence(
                      callback: () {
                        uploadedCount++;
                      },
                    ),
                    Gap(16.h),
                    NationalId(
                      callback: () {
                        uploadedCount++;
                      },
                    ),
                    Gap(16.h),
                    UnionID(
                      callback: () {
                        uploadedCount++;
                      },
                    ),
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
                child: Container(
                  margin: EdgeInsets.only(bottom: 16.h),
                  child: BlocConsumer<DocumentBloc, DocumentState>(
                    listener: (context, state) {
                      if (state is DocumentErrorState) {
                        toast(state.message);
                      }

                      if (state is DocumentUploadedState) {
                        context.push(
                          "/create-vehicle",
                          extra: "home",
                        ); // redirect to home
                      }
                    },
                    builder: (context, state) {
                      bool isLoading = false;
                      if (state is DocumentLoadingState) {
                        isLoading = true;
                      } else {
                        isLoading = false;
                      }

                      return TaxiAlongButton(
                        loading: isLoading,
                        onPressed: () {
                          if (uploadedCount >= 3) {
                            context
                                .read<DocumentBloc>()
                                .add(DocumentUploadCompleteEvent());
                          } else {
                            toast("You need to upload all three documents");
                          }
                        },
                        buttonText: "Next",
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'package:taxialong/core/services/get_it_services.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/core/widgets/taxi_along_cache_network_image.dart';
import 'package:taxialong/core/widgets/taxi_along_error_page.dart';
import 'package:taxialong/core/widgets/taxi_along_loading.dart';
import 'package:taxialong/features/documents/domain/entities/documents_entity.dart';
import 'package:taxialong/features/documents/presentation/bloc/document_bloc.dart';

class Documents extends StatefulWidget {
  const Documents({super.key});

  @override
  State<Documents> createState() => _DocumentsState();
}

class _DocumentsState extends State<Documents> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<DocumentBloc>(
      create: (context) => getIt<DocumentBloc>()..add(DocumentFetchDocuments()),
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
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16.w),
            child: BlocConsumer<DocumentBloc, DocumentState>(
              listener: (context, state) {
                if (state is DocumentErrorState) {
                  toast(state.message);
                }
              },
              builder: (context, state) {
                if (state is DocumentLoadingState) {
                  return TaxiAlongLoading(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? white
                        : dark,
                  );
                }
                if (state is DocumentsFetchedState) {
                  List<DocumentsEntity> documentsEntity = state.documentsEntity;
                  return Stack(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          children: [
                            for (int i = 0; i < documentsEntity.length; i++)
                              Container(
                                margin: EdgeInsets.only(bottom: 16.h),
                                width: 358.w,
                                padding: EdgeInsets.all(16.w),
                                decoration: ShapeDecoration(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? const Color(0xFF121212)
                                      : const Color(0x4CDADADA),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 1.w,
                                        color: const Color(0xFF77787B)),
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
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 358.w,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.w),
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.r)),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  (documentsEntity[i].type)
                                                      .replaceAll("_", " ")
                                                      .toUpperCase(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Gap(34.w),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                index = i;
                                              });
                                            },
                                            child: SizedBox(
                                              width: 40.w,
                                              height: 40.h,
                                              child: Stack(
                                                children: [
                                                  Positioned(
                                                    left: 0,
                                                    top: 0,
                                                    child: Container(
                                                      width: 40.w,
                                                      height: 40.h,
                                                      decoration:
                                                          ShapeDecoration(
                                                        color: white,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      50.r),
                                                        ),
                                                      ),
                                                      child: index == i
                                                          ? const Icon(
                                                              Icons
                                                                  .keyboard_arrow_up,
                                                            )
                                                          : const Icon(
                                                              Icons
                                                                  .keyboard_arrow_down,
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
                                    Gap(4.h),
                                    index == i
                                        ? Container(
                                            padding: EdgeInsets.only(
                                                top: 20.h,
                                                left: 16.w,
                                                bottom: 11.h),
                                            clipBehavior: Clip.antiAlias,
                                            decoration: ShapeDecoration(
                                              color: white,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.r)),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                TaxiAlongCachedNetworkImage(
                                                  path: documentsEntity[i].file,
                                                  width: 308,
                                                  height: 174,
                                                  fit: BoxFit.cover,
                                                  shape:
                                                      const BeveledRectangleBorder(),
                                                ),
                                              ],
                                            ),
                                          )
                                        : Container()
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return const TaxiAlongErrorPage();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

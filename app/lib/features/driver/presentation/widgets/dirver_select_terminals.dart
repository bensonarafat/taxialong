import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:taxialong/core/domain/entities/terminal_entity.dart';
import 'package:taxialong/core/domain/usecases/get_terminals_usecase.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/core/pages/taxi_along_terminals_page.dart';
import 'package:taxialong/core/services/get_it_services.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/core/widgets/taxi_along_error_widget.dart';
import 'package:taxialong/core/widgets/taxi_along_loading.dart';

class DriverSelectTerminals extends StatefulWidget {
  final String? pointa;
  final String? pointb;
  final Function callbacka;
  final Function callbackb;
  const DriverSelectTerminals({
    super.key,
    required this.pointa,
    required this.pointb,
    required this.callbacka,
    required this.callbackb,
  });

  @override
  State<DriverSelectTerminals> createState() => _DriverSelectTerminalsState();
}

class _DriverSelectTerminalsState extends State<DriverSelectTerminals> {
  GetTermainalUseCase getTermainalUseCase = getIt<GetTermainalUseCase>();
  String from = "Starting point";
  String to = "Ending point";
  bool loading = true;
  bool error = false;
  List<TerminalEntity>? terminals;
  pickeda(val) {
    from = val.name;
    setState(() {});
    widget.callbacka(val.id);
  }

  pickedb(val) {
    to = val.name;
    setState(() {});
    widget.callbackb(val.id);
  }

  @override
  void initState() {
    getTerminals();
    super.initState();
  }

  void getTerminals() async {
    final failureOrTerminalData = await getTermainalUseCase({});
    dartz.Either<Failure, List<TerminalEntity>> dartzterminals =
        failureOrTerminalData.fold(
      (failure) =>
          dartz.Left(ServerFailure(message: mapFailureToMessage(failure))),
      (terminalEntity) => dartz.Right(terminalEntity),
    );
    if (dartzterminals.isRight()) {
      terminals = dartzterminals.getOrElse(() => []);
      if (terminals != null) {
        if (widget.pointa != null) {
          final terminalEntity = terminals!.firstWhere(
            (e) => e.id == int.parse(widget.pointa!),
            // orElse: () => terminals!.first,
          );
          setState(() {
            from = terminalEntity.name;
          });
        } else {
          setState(() {
            from = 'Starting point';
          });
        }

        if (widget.pointb != null) {
          final terminalEntity = terminals!.firstWhere(
            (e) => e.id == int.parse(widget.pointb!),
            // orElse: () => terminals!.last,
          );

          setState(() {
            to = terminalEntity.name;
          });
        } else {
          setState(() {
            to = 'Ending point';
          });
        }
      } else {
        setState(() {
          from = 'Starting point';
          to = 'Ending point';
        });
      }
    } else {
      setState(() {
        error = false;
      });
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? TaxiAlongLoading(
            color:
                Theme.of(context).brightness == Brightness.dark ? white : dark,
          )
        : error
            ? const TaxiAlongErrorWidget()
            : Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select Terminal Locations',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Gap(16.h),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(_createRoute(terminals))
                                .then((terminal) {
                              pickeda(terminal);
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(16.w),
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side:
                                    BorderSide(width: 2.w, color: primaryColor),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  from,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .copyWith(
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Gap(16.w),
                                IconTheme(
                                  data: Theme.of(context).iconTheme,
                                  child: const Icon(
                                    Icons.keyboard_arrow_down,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Gap(12.w),
                      Text(
                        'To',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      Gap(12.w),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(_createRoute(terminals))
                                .then((terminal) {
                              pickedb(terminal);
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(16.w),
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side:
                                    BorderSide(width: 2.w, color: primaryColor),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  to,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .copyWith(
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Gap(16.w),
                                IconTheme(
                                  data: Theme.of(context).iconTheme,
                                  child: const Icon(
                                    Icons.keyboard_arrow_down,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
  }

  Route _createRoute(terminals) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          TaxiAlongTerminalsPage(
        terminals: terminals,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    );
  }
}

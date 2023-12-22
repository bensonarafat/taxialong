import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Fund extends StatefulWidget {
  const Fund({super.key});

  @override
  State<Fund> createState() => _FundState();
}

class _FundState extends State<Fund> {
  TextEditingController amountcontroller = TextEditingController();
  bool isWeb = false;

  WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          debugPrint('WebView is loading (progress : $progress%)');
        },
        onPageStarted: (String url) {
          debugPrint('Page started loading: $url');
        },
        onPageFinished: (String url) {
          debugPrint('Page finished loading: $url');
        },
        onWebResourceError: (WebResourceError error) {
          debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
        },
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse('https://flutter.dev'));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isWeb = !isWeb;
              });
            },
            icon: IconTheme(
              data: Theme.of(context).iconTheme,
              child: const Icon(Icons.refresh),
            ),
          ),
        ],
        title: const Text(
          'Fund Wallet',
        ),
        leading: GestureDetector(
          onTap: () {
            context.pop();
          },
          child: IconTheme(
            data: Theme.of(context).iconTheme,
            child: const Icon(
              Icons.keyboard_arrow_left,
            ),
          ),
        ),
      ),
      body: isWeb
          ? WebViewWidget(controller: controller)
          : Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    padding: EdgeInsets.all(16.w),
                    child: SizedBox(
                      width: 358.w,
                      child: TextFormField(
                        controller: amountcontroller,
                        maxLength: 5,
                        autofocus: true,
                        style:
                            Theme.of(context).textTheme.displayLarge!.copyWith(
                                  fontWeight: FontWeight.w900,
                                ),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "0",
                          hintStyle: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(
                                fontWeight: FontWeight.w900,
                              ),
                          prefix: Container(
                            padding: EdgeInsets.only(right: 8.w),
                            child: Text(
                              "₦",
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.w900,
                                  ),
                            ),
                          ),
                          suffix: Text(
                            ".00",
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(
                                  fontWeight: FontWeight.w900,
                                ),
                          ),
                          counterText: '',
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.only(
                      bottom: 40.h,
                    ),
                    width: 358.w,
                    height: 60.h,
                    child: TextButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            side: const BorderSide(
                              color: primaryColor,
                            ),
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(primaryColor),
                      ),
                      child: Text(
                        "Fund Wallet",
                        style: GoogleFonts.robotoFlex(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: white,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          isWeb = !isWeb;
                        });
                      },
                    ),
                  ),
                )
              ],
            ),
    );
  }
}

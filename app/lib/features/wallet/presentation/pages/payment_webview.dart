import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:go_router/go_router.dart';
import 'package:taxialong/core/constants/constants.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/features/wallet/domain/entities/initialize_entity.dart';

class PaymentWebView extends StatefulWidget {
  final InitializeEntity initializeEntity;
  const PaymentWebView({
    super.key,
    required this.initializeEntity,
  });

  @override
  State<PaymentWebView> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;
  InAppWebViewSettings settings = InAppWebViewSettings(
    isInspectable: kDebugMode,
    mediaPlaybackRequiresUserGesture: false,
    allowsInlineMediaPlayback: true,
  );

  PullToRefreshController? pullToRefreshController;
  late WebUri uri;
  double progress = 0;

  bool loading = true;
  @override
  void initState() {
    uri = WebUri(widget.initializeEntity.authorizationUrl);
    webViewController?.loadUrl(urlRequest: URLRequest(url: uri));
    pullToRefreshController = kIsWeb
        ? null
        : PullToRefreshController(
            settings: PullToRefreshSettings(
              color: primaryColor,
            ),
            onRefresh: () async {
              if (defaultTargetPlatform == TargetPlatform.android) {
                webViewController?.reload();
              } else if (defaultTargetPlatform == TargetPlatform.iOS) {
                webViewController?.loadUrl(
                    urlRequest:
                        URLRequest(url: await webViewController?.getUrl()));
              }
            });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: Stack(
        children: [
          InAppWebView(
            initialSettings: settings,
            initialUrlRequest: (URLRequest(
              url: uri,
            )),
            pullToRefreshController: pullToRefreshController,
            onWebViewCreated: (controller) {
              webViewController = controller;
            },
            onLoadStart: (controller, url) {},
            onLoadStop: (controller, url) async {
              pullToRefreshController?.endRefreshing();
            },
            onReceivedError: (controller, request, error) {
              pullToRefreshController?.endRefreshing();
            },
            onProgressChanged: (controller, progress) {
              if (progress == 100) {
                pullToRefreshController?.endRefreshing();
              }
              setState(() {
                this.progress = progress / 100;
              });
            },
            onUpdateVisitedHistory: (controller, WebUri? uri, androidIsReload) {
              if (uri != null) {
                String domain = "${uri.scheme}://${uri.authority}/api/";
                if (domain.startsWith(endpoint)) {
                  Uri urivalue = uri.uriValue;
                  String? trxref = urivalue.queryParameters['trxref'];
                  String? reference = uri.queryParameters['reference'];

                  context.pushReplacement(
                    "/verify-payment",
                    extra: {'trxref': trxref, 'reference': reference},
                  );
                }
              }
            },
            onConsoleMessage: (controller, consoleMessage) {
              if (kDebugMode) {}
            },
          ),
          progress < 1.0
              ? LinearProgressIndicator(
                  value: progress,
                  color: primaryColor,
                )
              : Container(),
        ],
      ),
    );
  }
}

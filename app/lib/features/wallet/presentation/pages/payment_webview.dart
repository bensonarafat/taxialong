import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taxialong/core/constants/constants.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/core/widgets/taxi_along_loading.dart';
import 'package:taxialong/features/wallet/domain/entities/initialize_entity.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
  late WebViewController webviewController;
  bool loading = true;
  @override
  void initState() {
    initWebView();
    super.initState();
  }

  void initWebView() {
    webviewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
            setState(() {
              loading = !loading;
            });
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith(endpoint)) {
              String url = request.url;
              Uri uri = Uri.parse(url);
              String? trxref = uri.queryParameters['trxref'];
              String? reference = uri.queryParameters['reference'];
              context.pushReplacement(
                "/verify-payment",
                extra: {'trxref': trxref, 'reference': reference},
              );
              return NavigationDecision.navigate;
            }
            return NavigationDecision.prevent;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.initializeEntity.authorizationUrl));
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
      body: loading
          ? TaxiAlongLoading(
              color: Brightness.dark == Theme.of(context).brightness
                  ? white
                  : dark,
            )
          : WebViewWidget(
              controller: webviewController,
            ),
    );
  }
}

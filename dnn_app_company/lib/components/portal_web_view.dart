import 'dart:developer';

import 'package:dnn_authentication/dnn_authentication.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PortalWebView extends StatefulWidget {
  const PortalWebView({super.key});

  @override
  State<PortalWebView> createState() => _PortalWebViewState();
}

class _PortalWebViewState extends State<PortalWebView> {
  final GlobalKey webViewKey = GlobalKey();
  final webViewController = WebViewController();
  final urlPage = Get.arguments['urlPage'];
  final title = Get.arguments['title'];

  @override
  void initState() {
    initController();
    super.initState();
  }

  Future<void> initController() async {
    final userCurrent = await webViewController.getUserAgent() ?? '';
    final currentTheme = Get.isDarkMode ? 'DnnDark' : 'DnnLight';
    String url = '';
    if (kReleaseMode) {
      url = 'https://portal.doutornanet.com.br$urlPage';
    } else {
      url =
          'https://hml-portal.doutornanet.com.br/impersonate?code=${authenticationController.impersonateCode}&route=$urlPage';
    }

    webViewController
      ..setUserAgent('$userCurrent DnnBrowser $currentTheme')
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Get.theme.scaffoldBackgroundColor)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));

    webViewController
      ..currentUrl().then((currentUrl) => log('currentUrl: $currentUrl'))
      ..getUserAgent().then((x) => log('USER AGENT: $x'))
      ..platform;
  }

  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: false,
      title: title,
      needScrollView: false,
      bodyChild: WebViewWidget(controller: webViewController),
      needPadding: false,
    );
  }
}

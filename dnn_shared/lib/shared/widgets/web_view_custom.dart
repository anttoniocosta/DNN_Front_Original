import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewCustom extends StatefulWidget {
  const WebViewCustom({super.key, required this.url});

  final String url;

  @override
  State<WebViewCustom> createState() => _WebViewCustomState();
}

class _WebViewCustomState extends State<WebViewCustom> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      useOnLoadResource: true,
      useShouldOverrideUrlLoading: true,
      mediaPlaybackRequiresUserGesture: true,
      javaScriptCanOpenWindowsAutomatically: true,
      javaScriptEnabled: true,
    ),
    android: AndroidInAppWebViewOptions(useHybridComposition: true),
    ios: IOSInAppWebViewOptions(
      allowsInlineMediaPlayback: true,
      allowsAirPlayForMediaPlayback: true,
      allowsPictureInPictureMediaPlayback: true,
      allowsLinkPreview: true,
      disallowOverScroll: true,
    ),
  );

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
      initialOptions: options,
      onWebViewCreated: (InAppWebViewController controller) {
        webViewController = controller;
      },
      androidOnPermissionRequest: (InAppWebViewController controller,
          String origin, List<String> resources) async {
        return PermissionRequestResponse(
          resources: resources,
          action: PermissionRequestResponseAction.GRANT,
        );
      },
      onConsoleMessage: (controller, consoleMessage) {
        log(consoleMessage.toString());
      },
      onProgressChanged: (controller, progress) {},
    );
  }
}

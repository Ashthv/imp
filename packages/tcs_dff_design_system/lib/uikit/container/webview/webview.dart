import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tcs_dff_route/route_navigator.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../dialog/error_dialog.dart';

enum WebViewContentType { url, html }

typedef NavigationDecisionRequest = NavigationDecision;

class WebView extends StatefulWidget {
  final String data;
  final WebViewContentType contentType;
  final Function(JavaScriptMessage data)? onMessageReceived;
  final FutureOr<NavigationDecisionRequest> Function(NavigationRequest)?
      onNavigationRequest;

  WebView({
    super.key,
    required this.data,
    this.contentType = WebViewContentType.url,
    this.onMessageReceived,
    this.onNavigationRequest,
  });

  @override
  State<StatefulWidget> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  late final WebViewController controller;
  bool showLoader = true;

  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (final _) {
            setState(() {
              showLoader = false;
            });
          },
          onWebResourceError: (final error) {
            showErrorDialog(context, Exception(error.description));
          },
          onNavigationRequest: widget.onNavigationRequest,
        ),
      );

    if (widget.onMessageReceived != null) {
      controller.addJavaScriptChannel(
        'DffChannel',
        onMessageReceived: widget.onMessageReceived!,
      );
    }

    switch (widget.contentType) {
      case WebViewContentType.url:
        controller.loadRequest(Uri.parse(widget.data));
      case WebViewContentType.html:
        controller.loadHtmlString(widget.data);
    }

    super.initState();
  }

  @override
  Widget build(final BuildContext context) => showLoader
      ? const Center(child: CircularProgressIndicator())
      : BackButtonListener(
          onBackButtonPressed: () async {
            if (await controller.canGoBack()) {
              await controller.goBack();
            } else {
              RouteNavigator.pop(context);
            }

            // Override/Block default back button functionality by above navigation within webview logic
            return true;
          },
          child: WebViewWidget(controller: controller),
        );
}

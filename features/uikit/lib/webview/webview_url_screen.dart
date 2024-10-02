import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/uikit/container/webview/webview.dart';

class WebviewUrlScreen extends StatelessWidget {
  const WebviewUrlScreen({super.key});

  @override
  Widget build(final BuildContext context) => WebView(
        data: 'https://flutter.dev/',
      );
}

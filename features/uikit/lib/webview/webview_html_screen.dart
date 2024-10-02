import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/uikit/container/webview/channel_data.dart';
import 'package:tcs_dff_design_system/uikit/container/webview/webview.dart';
import 'package:tcs_dff_route/tcs_dff_route.dart';

class WebviewHtmlScreen extends StatelessWidget {
  const WebviewHtmlScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    const kExamplePage = '''
<!DOCTYPE html>
<html lang="en">
<head>
<title>Load file or HTML string example</title>
</head>
<body>

<h1>Local demo page</h1>
<p>
 Check url intercept by clicking <a href="https://pub.dev/packages/webview_flutter">Flutter
 Webview Package</a>.
</p>
<p>
 Check navigation within webview by clicking <a href="https://flutter.dev">Flutter
 Website</a>.
</p>
<button type="button" onclick="myFunction()">Redirect to factory(di)</button>  
<script>  
function myFunction() {   
  DffChannel.postMessage(JSON.stringify({"type":"Demo","path":"/di/factory","extra":null}));
}  
</script>  

</body>
</html>
''';
    return WebView(
      data: kExamplePage,
      contentType: WebViewContentType.html,
      onMessageReceived: (final data) {
        if (data.message.isNotEmpty) {
          final channelData = WebViewChannelData.fromJson(data.message);
          RouteNavigator.push(context, channelData.path);
        } else {
          RouteNavigator.pop(context);
        }
      },
      onNavigationRequest: (final request) {
        if (request.url == 'https://pub.dev/packages/webview_flutter') {
          RouteNavigator.pop(context);
          return NavigationDecisionRequest.prevent;
        } else {
          return NavigationDecisionRequest.navigate;
        }
      },
    );
  }
}

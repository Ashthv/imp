import 'package:flutter/material.dart';
import 'package:tcs_dff_route/route_navigator.dart';

class WebviewScreen extends StatelessWidget {
  const WebviewScreen({super.key});

  @override
  Widget build(final BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                RouteNavigator.push(context, '/webview/url');
              },
              child: const Text('Url'),
            ),
            ElevatedButton(
              onPressed: () {
                RouteNavigator.push(context, '/webview/html');
              },
              child: const Text('Html'),
            ),
          ],
        ),
      );
}

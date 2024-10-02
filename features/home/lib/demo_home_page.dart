import 'package:flutter/material.dart';
import 'package:tcs_dff_route/route_navigator.dart';
import 'package:tcs_dff_shared_library/localization/app_localizations.dart';
import 'package:tcs_dff_storage/cache/cache.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Cache cache;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(final BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                RouteNavigator.push(context, '/home/di');
              },
              child: Text(
                context.locale.txt(key: 'newLogicKey'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                RouteNavigator.push(context, '/home/deviceAnalytics');
              },
              child: const Text('Device Analytics'),
            ),
            ElevatedButton(
              onPressed: () {
                RouteNavigator.push(context, '/home/network');
              },
              child: const Text('Network'),
            ),
            ElevatedButton(
              onPressed: () {
                RouteNavigator.push(context, '/home/storage');
              },
              child: const Text('Storage'),
            ),
            ElevatedButton(
              onPressed: () {
                RouteNavigator.push(context, '/home/deviceFeatures');
              },
              child: const Text('Device Features'),
            ),
            ElevatedButton(
              onPressed: () {
                RouteNavigator.push(context, '/home/uikit');
              },
              child: const Text('UIKit'),
            ),
            ElevatedButton(
              onPressed: () {
                RouteNavigator.push(context, '/home/cipher');
              },
              child: const Text('Cipher'),
            ),
            ElevatedButton(
              onPressed: () {
                RouteNavigator.push(context, '/home/dataPass');
              },
              child: const Text('Data Pass'),
            ),
            ElevatedButton(
              onPressed: () {
                RouteNavigator.push(context, '/home/featureFlag');
              },
              child: const Text('Feature Flag'),
            ),
            ElevatedButton(
              onPressed: () {
                RouteNavigator.push(context, '/home/security');
              },
              child: const Text('Security Feature'),
            ),
          ],
        ),
      );
}

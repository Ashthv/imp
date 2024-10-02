import 'package:flutter/material.dart';
import 'package:tcs_dff_route/route_navigator.dart';

class AnalyticsHomeView extends StatelessWidget {
  const AnalyticsHomeView({super.key});

  @override
  Widget build(final BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                RouteNavigator.push(context, '/deviceAnalytics/analytics');
              },
              child: const Text('Analytics'),
            ),
            ElevatedButton(
              onPressed: () {
                RouteNavigator.push(context, '/deviceAnalytics/crashlytics');
              },
              child: const Text('Crashlytics'),
            ),
          ],
        ),
      );
}

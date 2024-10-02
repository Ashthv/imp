import 'package:flutter/material.dart';
import 'package:tcs_dff_route/route_navigator.dart';

class TabviewScreen extends StatelessWidget {
  const TabviewScreen({super.key});

  @override
  Widget build(final BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                RouteNavigator.push(context, '/tabSwitch/tabs');
              },
              child: const Text('Tabs'),
            ),
            ElevatedButton(
              onPressed: () {
                RouteNavigator.push(context, '/tabSwitch/tabsWithBadge');
              },
              child: const Text('Tabs with Badge'),
            ),
            ElevatedButton(
              onPressed: () {
                RouteNavigator.push(context, '/tabSwitch/tabsWithIcon');
              },
              child: const Text('Tab with Icons'),
            ),
            ElevatedButton(
              onPressed: () {
                RouteNavigator.push(context, '/tabSwitch/fullPageTab');
              },
              child: const Text('Full Page Tab'),
            ),
            ElevatedButton(
              onPressed: () {
                RouteNavigator.push(context, '/tabSwitch/sectionTab');
              },
              child: const Text('Section Tab'),
            ),
          ],
        ),
      );
}

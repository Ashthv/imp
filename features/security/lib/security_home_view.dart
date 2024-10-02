import 'package:flutter/material.dart';
import 'package:tcs_dff_route/route_navigator.dart';

class SecurityHomeView extends StatelessWidget {
  const SecurityHomeView({super.key});

  @override
  Widget build(final BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                RouteNavigator.push(context, '/security/insecure_wifi');
              },
              child: const Text('Insecure Wifi'),
            ),
            ElevatedButton(
              onPressed: () {
                RouteNavigator.push(context, '/security/authenticity_detect');
              },
              child: const Text('Authenticity Detect'),
            ),
             ElevatedButton(
              onPressed: () {
                RouteNavigator.push(context, '/security/vulnerable_detect');
              },
              child: const Text('Vulnerable Detect'),
            ),
          ],
        ),
      );
}

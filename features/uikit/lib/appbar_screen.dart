import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/tcs_dff_design_system.dart';
import 'package:tcs_dff_route/route_navigator.dart';

class AppBarScreen extends StatefulWidget {
  const AppBarScreen({super.key});

  @override
  State<AppBarScreen> createState() => _AppBarScreenState();
}

class _AppBarScreenState extends State<AppBarScreen> {
  @override
  Widget build(final BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            NormalButton(
              onPressed: () {
                RouteNavigator.push(context, '/appBarScreen/defaultAppBar');
              },
              caption: 'Default App Bar',
              buttonType: ButtonVariants.cardFourColumn,
            ),
            NormalButton(
              onPressed: () {
                RouteNavigator.push(context, '/appBarScreen/progressAppBar');
              },
              caption: 'Progress App Bar',
              buttonType: ButtonVariants.cardFourColumn,
            ),
            NormalButton(
              onPressed: () {
                RouteNavigator.push(
                  context,
                  '/appBarScreen/iconSubSectionAppBar',
                );
              },
              caption: 'Icon Sub Section App Bar',
              buttonType: ButtonVariants.cardFourColumn,
            ),
            NormalButton(
              onPressed: () {
                RouteNavigator.push(context, '/appBarScreen/searchAppBar');
              },
              caption: 'Search App Bar',
              buttonType: ButtonVariants.cardFourColumn,
            ),
          ],
        ),
      );
}

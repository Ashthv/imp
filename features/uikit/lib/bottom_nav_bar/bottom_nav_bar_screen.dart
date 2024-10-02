import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/utils/bottom_nav_bar_utils.dart';
import 'bottom_nav_bar_horizontal.dart';
import 'bottom_nav_bar_vertical.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  final List<NavBarIconData> bottomNavigationIconsVertical = const [
    NavBarIconData(iconPath: 'images/add.png', iconLabel: 'Locate'),
    NavBarIconData(iconPath: 'images/add.png', iconLabel: 'label'),
    NavBarIconData(iconPath: 'images/add.png', iconLabel: 'label'),
    NavBarIconData(iconPath: 'images/add.png', iconLabel: 'No label'),
  ];

  final List<NavBarIconData> bottomNavigationIconsHorizontal = const [
    NavBarIconData(iconPath: 'images/add.png', iconLabel: 'Locate'),
    NavBarIconData(iconPath: 'images/add.png', iconLabel: 'label'),
  ];

  bool isCentralButtonPressed = false;

  // For demo purpose
  bool isHorizontal = true;

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (final context) =>
                            const BottomNavBarHorizontal(),
                      ),
                    );
                  },
                  child: const Text('Horizontal'),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (final context) =>
                            const BottomNavBarVertical(),
                      ),
                    );
                  },
                  child: const Text('Vertical'),
                ),
              ],
            ),
          ),
        ),
      );
}

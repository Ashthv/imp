import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/uikit/container/bottom_nav_bar.dart';
import 'package:tcs_dff_design_system/uikit/foundation/button/round_button.dart';
import 'package:tcs_dff_design_system/utils/bottom_nav_bar_utils.dart';
import 'package:tcs_dff_design_system/utils/button_utils.dart';

class BottomNavBarHorizontal extends StatefulWidget {
  const BottomNavBarHorizontal({super.key});

  @override
  State<BottomNavBarHorizontal> createState() => _BottomNavBarHorizontalState();
}

class _BottomNavBarHorizontalState extends State<BottomNavBarHorizontal> {
  final List<NavBarIconData> bottomNavigationIconsHorizontal = const [
    NavBarIconData(iconPath: 'images/add.png', iconLabel: 'Locate'),
    NavBarIconData(iconPath: 'images/add.png', iconLabel: 'label'),
  ];

  bool isCenterButtonPressed = false;

  @override
  Widget build(final BuildContext context) {
    final color = context.theme.appColor;
    return Scaffold(
      floatingActionButton: RoundButton(
        onPressed: () {
          isCenterButtonPressed = true;
          setState(() {});
        },
        buttonVariant: ButtonVariants.circular,
        iconPath: 'images/ic_arrow_forward.svg',
        package: 'uikit',
        buttonColor: color.greyFullWhite120,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavBar(
        bottomNavigationIcons: bottomNavigationIconsHorizontal,
        isCenterButtonPressed: isCenterButtonPressed,
        onIconClicked: () {
          isCenterButtonPressed = false;
          setState(() {});
        },
        bottomBarAlignment: BottomBarAlignment.horizontal,
      ),
    );
  }
}

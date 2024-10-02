import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/uikit/container/bottom_nav_bar.dart';
import 'package:tcs_dff_design_system/uikit/foundation/button/round_button.dart';
import 'package:tcs_dff_design_system/utils/bottom_nav_bar_utils.dart';
import 'package:tcs_dff_design_system/utils/button_utils.dart';

class BottomNavBarVertical extends StatefulWidget {
  const BottomNavBarVertical({super.key});

  @override
  State<BottomNavBarVertical> createState() => _BottomNavBarVerticalState();
}

class _BottomNavBarVerticalState extends State<BottomNavBarVertical> {
  final List<NavBarIconData> bottomNavigationIconsVertical = const [
    NavBarIconData(iconPath: 'images/add.png', iconLabel: 'Locate'),
    NavBarIconData(iconPath: 'images/add.png', iconLabel: 'label'),
    NavBarIconData(iconPath: 'images/add.png', iconLabel: 'label'),
    NavBarIconData(iconPath: 'images/add.png', iconLabel: 'No label'),
  ];

  bool isCenterButtonPressed = false;

  @override
  Widget build(final BuildContext context) => Scaffold(
        floatingActionButton: RoundButton(
          onPressed: () {
            isCenterButtonPressed = true;
            setState(() {});
          },
          buttonVariant: ButtonVariants.circular,
          iconPath: 'images/arrow_rightt.svg',
          package: 'uikit',
          buttonColor: context.theme.appColor.greyFullWhite120,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavBar(
          bottomNavigationIcons: bottomNavigationIconsVertical,
          centerButtonData: 'Scan & Pay',
          isCenterButtonPressed: isCenterButtonPressed,
          package: 'uikit',
          onIconClicked: () {
            isCenterButtonPressed = false;
            setState(() {});
          },
        ),
      );
}

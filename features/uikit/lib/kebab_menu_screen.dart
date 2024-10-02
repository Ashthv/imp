import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/tcs_dff_design_system.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_shared_library/localization/app_localizations.dart';

class KebabMenuScreen extends StatelessWidget {
  const KebabMenuScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    final locale = context.locale;
    final color = context.theme.appColor;
    final popUpMenu = <MenuItemModel>[
      MenuItemModel(
        id: 1,
        lable: 'Payment History',
      ),
      MenuItemModel(
        id: 2,
        lable: 'Manage Autopay',
      ),
      MenuItemModel(
        id: 3,
        lable: 'Bill Reminders',
      ),
      MenuItemModel(
        id: 4,
        lable: 'Analyze',
        isToggleButtonShow: true,
        isToggleActive: true,
      ),
      MenuItemModel(
        id: 5,
        lable: 'Edit Nickname',
      ),
      MenuItemModel(
        id: 6,
        lable: 'Remove Biller',
        isToggleButtonShow: true,
      ),
    ];
    return Scaffold(
      appBar: DefaultAppBar(
        title: locale.txt(key: 'kebabMenu'),
        actions: [
          KebabMenuWidget(
            list: popUpMenu,
            onPressed: (final index) {},
            onTap: (final bool value) {},
            icon: Icon(
              Icons.more_vert,
              color: color.clrPrimaryPurple,
            ),
          ),
        ],
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              KebabMenuWidget(
                list: popUpMenu,
                onPressed: (final index) {},
                onTap: (final bool value) {},
                icon: ImageWidget(
                  imageType: ImageType.assetImage,
                  path: 'images/pigybank.png',
                  package: 'uikit',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

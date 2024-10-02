import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/tcs_dff_design_system.dart';
import 'package:tcs_dff_design_system/uikit/foundation/tabbar/tab_data.dart';

import '../login_tabs/login_tabs_export.dart';

class TabScreenIcon extends StatefulWidget {
  const TabScreenIcon({super.key});

  @override
  State<TabScreenIcon> createState() => _TabScreenIconState();
}

class _TabScreenIconState extends State<TabScreenIcon> {
  final List<TabData> _headingList1 = [
    TabData(
      title: 'My Insurance',
      imagePath: 'images/home.svg',
      body: const MPinTab(),
      imagePackage: 'uikit',
    ),
    TabData(
      title: 'My Credit card',
      imagePath: 'images/home.svg',
      body: const FingerprintTab(),
      imagePackage: 'uikit',
    ),
    TabData(
      title: 'My wearables',
      imagePath: 'images/home.svg',
      body: const FingerprintTab(),
      imagePackage: 'uikit',
    ),
  ];

  @override
  Widget build(final BuildContext context) => Container(
        child: Column(
          children: [
            Expanded(
              child: Tabs(
                tabDataList: _headingList1,
              ),
            ),
          ],
        ),
      );
}

import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/uikit/foundation/tabbar/tab_data.dart';
import 'package:tcs_dff_design_system/uikit/foundation/tabbar/tabs.dart';

import '../login_tabs/login_tabs_export.dart';

class TabsScreenBadge extends StatefulWidget {
  const TabsScreenBadge({super.key});

  @override
  State<TabsScreenBadge> createState() => _TabsScreenBadgeState();
}

class _TabsScreenBadgeState extends State<TabsScreenBadge> {
  final List<TabData> _headingList = [
    TabData(
      title: 'Tab1',
      body: const UsernameTab(),
    ),
    TabData(
      title: 'Tab2',
      body: const UsernameTab(),
      count: 72,
    ),
    TabData(
      title: 'Tab3',
      body: const FingerprintTab(),
      count: 15,
    ),
    TabData(
      title: 'Tab4',
      body: const UsernameTab(),
      count: 5,
    ),
  ];

  @override
  Widget build(final BuildContext context) => Column(
        children: [
          Expanded(
            child: Tabs(
              tabDataList: _headingList,
            ),
          ),
        ],
      );
}

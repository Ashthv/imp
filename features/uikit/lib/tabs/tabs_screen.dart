import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/uikit/foundation/tabbar/tab_data.dart';
import 'package:tcs_dff_design_system/uikit/foundation/tabbar/tabs.dart';

import '../login_tabs/login_tabs_export.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<TabData> _headingList = [
    TabData(
      title: 'Tab1',
      body: const UsernameTab(),
    ),
    TabData(
      title: 'Tab2',
      body: const MPinTab(),
    ),
    TabData(
      title: 'Tab3',
      body: const MPinTab(),
    ),
    TabData(
      title: 'Tab4',
      body: const UsernameTab(),
    ),
    TabData(
      title: 'Tab5',
      body: const FingerprintTab(),
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

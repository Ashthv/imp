import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/uikit/foundation/tabbar/tab_data.dart';
import 'package:tcs_dff_design_system/uikit/foundation/tabbar/tabs.dart';

import '../login_tabs/login_tabs_export.dart';

class FullPageTabScreen extends StatefulWidget {
  const FullPageTabScreen({super.key});

  @override
  State<FullPageTabScreen> createState() => _FullPageTabScreenState();
}

class _FullPageTabScreenState extends State<FullPageTabScreen> {
  final List<TabData> _headingList1 = [
    TabData(
      title: 'My Insurance',
      imagePath: 'images/category_ic_credit_card.svg',
      body: const MPinTab(),
      imagePackage: 'uikit',
    ),
    TabData(
      title: 'My Credit Card',
      imagePath: 'images/category_ic_credit_card.svg',
      body: const FingerprintTab(),
      imagePackage: 'uikit',
    ),
    TabData(
      title: 'My Wearables',
      imagePath: 'images/category_ic_credit_card.svg',
      body: const UsernameTab(),
      imagePackage: 'uikit',
    ),
  ];

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: Tabs(
          tabDataList: _headingList1,
          tabType: TabType.fullPageTab,
        ),
      );
}

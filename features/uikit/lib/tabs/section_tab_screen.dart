import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/uikit/foundation/tabbar/section_tab.dart';
import 'package:tcs_dff_design_system/uikit/foundation/tabbar/tab_data.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';

import '../login_tabs/login_tabs_export.dart';

class SectionTabScreen extends StatefulWidget {
  const SectionTabScreen({super.key});

  @override
  State<SectionTabScreen> createState() => _SectionTabScreenState();
}

class _SectionTabScreenState extends State<SectionTabScreen> {
  final List<TabData> _headingList1 = [
    TabData(
      title: 'Transact',
      body: const MPinTab(),
    ),
    TabData(
      title: 'Explore',
      body: const FingerprintTab(),
    ),
    TabData(
      title: 'Rewards',
      body: const FingerprintTab(),
    ),
    TabData(
      title: 'Reedem',
      body: const FingerprintTab(),
    ),
    TabData(
      title: 'Transfer',
      body: const FingerprintTab(),
    ),
  ];

  @override
  Widget build(final BuildContext context) {
    final color = context.theme.appColor;
    final size = context.theme.appSize;

    return Container(
      color:
          color.clrPrimaryPurple120, // color.greyWhiteUi100 (backgroundWhiteUI)
      padding: EdgeInsets.symmetric(vertical: size.size16.dp),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SectionTab(
              tabDataList: _headingList1,
            ),
            SizedBox(height: size.size50),
            SectionTab(
              tabDataList: _headingList1,
            ),
            SizedBox(height: size.size50),
            SectionTab(
              tabDataList: _headingList1,
            ),
            SizedBox(height: size.size50),
            SectionTab(
              tabDataList: _headingList1,
            ),
          ],
        ),
      ),
    );
  }
}

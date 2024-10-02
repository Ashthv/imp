import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';

class MPinTab extends StatefulWidget {
  const MPinTab({super.key, this.linkColor});
  final Color? linkColor;

  @override
  State<MPinTab> createState() => _MPinTabState();
}

class _MPinTabState extends State<MPinTab> {
  String testingPin = '1234';
  bool pinValidator(final String pinEntered) => pinEntered == testingPin;

  @override
  Widget build(final BuildContext context) => Padding(
        padding: EdgeInsets.only(
          top: context.theme.appSize.size10.dp,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter Your Content',
              style: context.theme.appTextStyles.labelSmall18Medium.copyWith(
                color: context.theme.appColor.greyLighterGrey70,
                fontWeight: FontWeight.w500,
                fontSize: context.theme.appSize.size18.dp,
              ),
            ),
          ],
        ),
      );
}

import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/uikit/foundation/icon_widget.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';

class IconsScreen extends StatelessWidget {
  const IconsScreen({super.key});

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Small Icons'),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconWidget(
                  iconName: 'images/add.png',
                  iconSize: IconSize.small,
                  package: 'uikit',
                ),
                IconWidget(
                  iconName: 'images/alarm_on.png',
                  iconSize: IconSize.small,
                  package: 'uikit',
                ),
                IconWidget(
                  iconName: 'images/arrow_backward.png',
                  iconSize: IconSize.small,
                  package: 'uikit',
                ),
                IconWidget(
                  iconName: 'images/arrow_forward.png',
                  iconSize: IconSize.small,
                  package: 'uikit',
                ),
              ],
            ),
            SizedBox(height: context.theme.appSize.size12.dp),
            const Text('Large Icons'),
            SizedBox(height: context.theme.appSize.size12.dp),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconWidget(
                  iconName: 'images/bargraph.png',
                  iconSize: IconSize.large,
                  package: 'uikit',
                ),
                IconWidget(
                  iconName: 'images/bill_payments.png',
                  package: 'uikit',
                  iconSize: IconSize.large,
                ),
                IconWidget(
                  iconName: 'images/clock.png',
                  package: 'uikit',
                  iconSize: IconSize.large,
                ),
                IconWidget(
                  iconName: 'images/close.png',
                  package: 'uikit',
                  iconSize: IconSize.large,
                ),
              ],
            ),
            SizedBox(height: context.theme.appSize.size12.dp),
            const Text('Clickable Icons'),
            SizedBox(height: context.theme.appSize.size12.dp),
            IconWidget(
              iconName: 'images/cloud_download.png',
              iconSize: IconSize.small,
              package: 'uikit',
              iconColor: context.theme.appColor.clrPrimaryPurple,
              onPressed: () {
                const snackBar = SnackBar(content: Text('Icon Pressed'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            ),
          ],
        ),
      );
}

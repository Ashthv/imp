import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/tcs_dff_design_system.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';

class BadgeScreen extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BadgeWidget(),
          SizedBox(
            height: size.size24.dp,
          ),
          BadgeWidget(
            notificationCount: 5,
          ),
          SizedBox(
            height: size.size24.dp,
          ),
          BadgeWidget(
            notificationCount: 10,
            title: 'Notification',
          ),
        ],
      ),
    );
  }
}

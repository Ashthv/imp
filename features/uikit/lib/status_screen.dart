import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/uikit/foundation/status_widget.dart';

import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';
import 'package:tcs_dff_shared_library/localization/app_localizations.dart';

class StatusTypesScreen extends StatelessWidget {
  const StatusTypesScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    final locale = context.locale;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: context.theme.appSize.size50.dp,
              width: context.theme.appSize.size10,
            ),
            SizedBox(height: context.theme.appSize.size15.dp),
            StatusTypesWidget(
              text: locale.txt(key: 'successful'),
              statusType: StatusTypes.successful,
            ),
            SizedBox(height: context.theme.appSize.size15.dp),
            StatusTypesWidget(
              text: locale.txt(key: 'pending'),
              statusType: StatusTypes.pending,
              bgColor: context.theme.appColor.statLightAmber,
            ),
             SizedBox(height: context.theme.appSize.size15.dp),
            StatusTypesWidget(
              text: locale.txt(key: 'failed'),
              statusType: StatusTypes.failed,
              bgColor: context.theme.appColor.statRedLightRed,
            ),
             SizedBox(height: context.theme.appSize.size15.dp),
            StatusTypesWidget(
              text: locale.txt(key: 'closed'),
              statusType: StatusTypes.closed,
              bgColor: context.theme.appColor.greyOffWhite90,
            ),
            SizedBox(height: context.theme.appSize.size30.dp),
            StatusTypesWidget(
              text: locale.txt(key: 'successful'),
              icon: 'images/check_statuss.svg',
              statusType: StatusTypes.closed,
              imgPackage: 'uikit',
              bgColor: context.theme.appColor.transparent,
            ),
            SizedBox(height: context.theme.appSize.size15.dp),
            StatusTypesWidget(
              text: locale.txt(key: 'pending'),
              icon: 'images/pendingstatusy.svg',
              statusType: StatusTypes.closed,
              imgPackage: 'uikit',
              bgColor: context.theme.appColor.transparent,
            ),
            SizedBox(height: context.theme.appSize.size15.dp),
            StatusTypesWidget(
              text: locale.txt(key: 'failed'),
              icon: 'images/faildr.svg',
              statusType: StatusTypes.closed,
              imgPackage: 'uikit',
              bgColor: context.theme.appColor.transparent,
            ),
          ],
        ),
      ),
    );
  }
}

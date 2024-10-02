// Total time :- Total time for which the functionality is disabled for user
// Lapse time :- Remaining time after user started the application again.

import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/uikit/container/bottomsheet/bottomsheet_template.dart';
import 'package:tcs_dff_design_system/uikit/container/timer_widget.dart';
import 'package:tcs_dff_design_system/uikit/foundation/text_widget.dart';
import 'package:tcs_dff_design_system/utils/bottom_sheet.dart';
import 'package:tcs_dff_design_system/utils/bottomsheet_template_model.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';
import 'package:tcs_dff_route/tcs_dff_route.dart';
import 'package:tcs_dff_shared_library/localization/app_localizations.dart';

class TimerWidgetScreen extends StatelessWidget {
  const TimerWidgetScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    final locale = context.locale;
    final size = context.theme.appSize;
    final bottomsheetTemplateData = BottomsheetTemplateData(
      content: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: TextWidget(
              text: locale.txt(key: 'timerText'),
            ),
          ),
          TimerWidget(
            totalTime: const Duration(minutes: 1),
            hourText: locale.txt(key: 'hours'),
            minuteText: locale.txt(key: 'minutes'),
            radiusFactor: size.size75.dp / size.size100.dp,
          ),
        ],
      ),
      primaryButtonText: locale.txt(key: 'verify'),
      onCloseButtonTap: () {
        RouteNavigator.popDialog(context);
      },
    );
    return Scaffold(
      body: ElevatedButton(
        child: Text(locale.txt(key: 'showTemplate')),
        onPressed: () {
          showBottomSheetModal(
            context,
            BottomsheetTemplate(
              bottomsheetTemplateData: bottomsheetTemplateData,
            ),
          );
        },
      ),
    );
  }
}

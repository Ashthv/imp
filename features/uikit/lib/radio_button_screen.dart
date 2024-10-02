import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/tcs_dff_design_system.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';
import 'package:tcs_dff_shared_library/localization/app_localizations.dart';

class RadioButtonScreen extends StatefulWidget {
  const RadioButtonScreen({super.key});

  @override
  State<RadioButtonScreen> createState() => _RadioButtonScreenState();
}

class _RadioButtonScreenState extends State<RadioButtonScreen> {
  bool yesSelected = true, noSelected = false;

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final locale = context.locale;
    return Scaffold(
      body: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioButtonTitleSubtitle(
              subTitle: locale.txt(key: 'fileUploadText'),
              title: locale.txt(key: 'yes'),
              onChanged: (final bool value) {
                setState(() {
                  if (!value) {
                    yesSelected = true;
                    noSelected = false;
                  }
                });
              },
              isSelected: yesSelected,
            ),
            SizedBox(
              width: size.size10.dp,
            ),
            RadioButtonTitleSubtitle(
              title: locale.txt(key: 'no'),
              onChanged: (final bool value) {
                setState(() {
                  if (!value) {
                    noSelected = !noSelected;
                    yesSelected = false;
                  }
                });
              },
              isSelected: noSelected,
            ),
          ],
        ),
      ),
    );
  }
}

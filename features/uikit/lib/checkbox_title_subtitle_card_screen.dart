import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/tcs_dff_design_system.dart';
import 'package:tcs_dff_shared_library/localization/app_localizations.dart';

class CheckboxTitleSubtitleCardScreen extends StatefulWidget {
  const CheckboxTitleSubtitleCardScreen({super.key});

  @override
  State<CheckboxTitleSubtitleCardScreen> createState() =>
      _CheckboxTitleSubtitleCardScreenState();
}

bool t = false;

class _CheckboxTitleSubtitleCardScreenState
    extends State<CheckboxTitleSubtitleCardScreen> {
  @override
  Widget build(final BuildContext context) {
    final locale = context.locale;
    return Scaffold(
      body: Column(
        children: [
          CheckboxTitleSubtitleCard(
            title: locale.txt(key: 'termsAndConditions'),
            onChanged: (final bool val) {
              setState(() {
                t = !t;
              });
            },
            isChecked: t,
            subTitle: locale.txt(key: 'titleSubtitleSubheading'),
          ),
          CheckboxTitleSubtitleCard(
            disabled: true,
            title: locale.txt(key: 'termsAndConditions'),
            onChanged: (final bool val) {},
            subTitle: locale.txt(key: 'titleSubtitleSubheading'),
          ),
        ],
      ),
    );
  }
}

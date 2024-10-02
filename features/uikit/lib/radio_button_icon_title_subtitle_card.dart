import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/tcs_dff_design_system.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';
import 'package:tcs_dff_shared_library/localization/app_localizations.dart';

class RadioButtonIconTitleSubtitleCardScreen extends StatefulWidget {
  const RadioButtonIconTitleSubtitleCardScreen({super.key});

  @override
  State<RadioButtonIconTitleSubtitleCardScreen> createState() =>
      _RadioButtonIconTitleSubtitleCardScreenState();
}

class _RadioButtonIconTitleSubtitleCardScreenState
    extends State<RadioButtonIconTitleSubtitleCardScreen> {
  bool yesSelected = true;
  bool noSelected = false;

  @override
  Widget build(final BuildContext context) {
    final locale = context.locale;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            RadioButtonTitleSubtitleCard(
              title: locale.txt(key: 'termsAndConditions'),
              subTitle: locale.txt(key: 'termsAndConditions'),
              onChanged: (final bool value) {
                setState(() {
                  if (!value) {
                    yesSelected = !yesSelected;
                    noSelected = !noSelected;
                  }
                });
              },
              isSelected: yesSelected,
            ),
            SizedBox(height: context.theme.appSize.size15.dp),
            RadioButtonTitleSubtitleCard(
              title: locale.txt(key: 'termsAndConditions'),
              subTitle: locale.txt(key: 'termsAndConditions'),
              onChanged: (final value) {
                setState(() {
                  if (!value) {
                    yesSelected = !yesSelected;
                    noSelected = !noSelected;
                  }
                });
              },
              isSelected: noSelected,
            ),
            SizedBox(height: context.theme.appSize.size15.dp),
            RadioButtonIconTitleSubtitleCard(
              title: locale.txt(key: 'termsAndConditions'),
              subTitle: locale.txt(key: 'termsAndConditions'),
              onChanged: (final value) {},
              isSelected: yesSelected,
              leadingImagePath: 'images/bankimage.svg',
              package: 'uikit',
            ),
            SizedBox(height: context.theme.appSize.size15.dp),
            RadioButtonIconTitleSubtitleCard(
              title: locale.txt(key: 'termsAndConditions'),
              onChanged: (final value) {},
              isSelected: yesSelected,
              leadingImagePath: 'images/bankimage.svg',
              package: 'uikit',
            ),
            SizedBox(height: context.theme.appSize.size15.dp),
            RadioButtonIconTitleSubtitleCard(
              title: locale.txt(key: 'termsAndConditions'),
              subTitle: locale.txt(key: 'termsAndConditions'),
              onChanged: (final value) {},
              isSelected: noSelected,
            ),
            SizedBox(height: context.theme.appSize.size15.dp),
            RadioButtonIconTitleSubtitleCard(
              title: locale.txt(key: 'termsAndConditions'),
              subTitle: locale.txt(key: 'termsAndConditions'),
              onChanged: (final value) {},
              isSelected: true,
              isEnabled: false,
              leadingImagePath: 'images/bankimage.svg',
              package: 'uikit',
            ),
          ],
        ),
      ),
    );
  }
}

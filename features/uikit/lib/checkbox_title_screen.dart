import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/tcs_dff_design_system.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';
import 'package:tcs_dff_shared_library/localization/app_localizations.dart';

class CheckboxTitleScreen extends StatefulWidget {
  const CheckboxTitleScreen({
    super.key,
  });

  @override
  State<CheckboxTitleScreen> createState() => _CheckboxTitleScreen();
}

class _CheckboxTitleScreen extends State<CheckboxTitleScreen> {
  void onChanged(final bool value) {}

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final color = context.theme.appColor;
    final style = context.theme.appTextStyles;
    final locale = context.locale;
    return Scaffold(
      backgroundColor: color.greyFullWhite120,
      body: Padding(
        padding: EdgeInsets.only(
          left: size.size20.dp,
          right: size.size20.dp,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CheckboxTitle(
              textWidget: TextWidget(
                text: locale.txt(key: 'termsAndConditions'),
                style: style.h316pxsemiBold.copyWith(
                  color: color.greyBlackUi10,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onChanged: onChanged,
            ),
            SizedBox(
              height: size.size10.dp,
            ),
            Padding(
              padding: EdgeInsets.only(right: size.size20.dp),
              child: CheckboxTitle(
                textWidget: TextWidget(
                  text: locale.txt(key: 'termsAndConditions'),
                  style: style.h316pxsemiBold.copyWith(
                    color: color.greyBlackUi10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                disabled: true,
              ),
            ),
            SizedBox(
              height: size.size10.dp,
            ),
            CheckboxTitle(
              textWidget: TextWidget(
                text: locale.txt(key: 'termsAndConditions'),
                style: style.h316pxsemiBold.copyWith(
                  color: color.greyBlackUi10,
                  fontWeight: FontWeight.w500,
                ),
              ),
              disabled: true,
              isChecked: true,
            ),
            SizedBox(
              height: size.size10.dp,
            ),
            CheckboxTitle(
              textWidget: TextWidget(
                text: locale.txt(key: 'termsAndConditions'),
                style: style.h316pxsemiBold.copyWith(
                  color: color.greyBlackUi10,
                  fontWeight: FontWeight.w500,
                ),
              ),
              isMixed: true,
              // can pass isMixed as True to show Mixed State
            ),
            SizedBox(
              height: size.size10.dp,
            ),
            CheckboxTitle(
              textWidget: TextWidget(
                text: locale.txt(key: 'termsAndConditions'),
                style: style.h316pxsemiBold.copyWith(
                  color: color.greyBlackUi10,
                  fontWeight: FontWeight.w500,
                ),
              ),
              isMixed: true,
              disabled: true,
              onInfoPressed: () {},
              // can pass onInfoPressed as Function to show Info Button
            ),
            SizedBox(
              height: size.size10.dp,
            ),
            CheckboxTitle(
              textWidget: TextWidget(
                text: locale.txt(key: 'termsAndConditions'),
                style: style.h316pxsemiBold.copyWith(
                  color: color.greyBlackUi10,
                  fontWeight: FontWeight.w500,
                ),
              ),
              isMixed: true,
              withBackgroundCard: true,
              // can pass withBackgroundCard as true to show background card
            ),
            SizedBox(
              height: size.size10.dp,
            ),
            CheckboxTitle(
              textWidget: TextWidget(
                text: locale.txt(key: 'termsAndConditions'),
                style: style.h316pxsemiBold.copyWith(
                  color: color.greyBlackUi10,
                  fontWeight: FontWeight.w500,
                ),
              ),
              disabled: true,
              onInfoPressed: () {},
              withBackgroundCard: true,
            ),
          ],
        ),
      ),
    );
  }
}

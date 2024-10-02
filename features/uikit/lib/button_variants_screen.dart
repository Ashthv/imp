import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/tcs_dff_design_system.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';
import 'package:tcs_dff_shared_library/localization/app_localizations.dart';

class ButtonVariantsScreen extends StatelessWidget {
  const ButtonVariantsScreen({super.key});

  void onTapTime(final DateTime str, final bool isClicked) {}

  void onTapDate(final String day, final String date) {}

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final color = context.theme.appColor;
    final locale = context.locale;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(
          size.size8.dp,
        ),
        child: Column(
          children: [
            NormalButton(
              caption: locale.txt(key: 'proceed'),
              onPressed: () {},
              buttonType: ButtonVariants.cardFourColumn,
              borderColor: color.clrPrimaryBlue,
              captionColor: color.greyFullWhite120,
              overleyColor: color.greyFullBlack10,
            ),
            SizedBox(
              height: size.size20.dp,
            ),
            NormalButton(
              caption: locale.txt(key: 'proceed'),
              onPressed: () {},
              buttonType: ButtonVariants.cardTwoColumn,
              isEnabled: false,
              package: 'uikit',
            ),
            SizedBox(
              height: size.size20.dp,
            ),
            BorderlinedButton(
              caption: locale.txt(key: 'proceed'),
              onPressed: () {},
              buttonType: ButtonVariants.fourColumn,
              leftIcon: 'images/choose_doc.png',
              rightIcon: 'images/add.png',
              package: 'uikit',
            ),
            SizedBox(
              height: size.size20.dp,
            ),
            BorderlinedButton(
              caption: locale.txt(key: 'proceed'),
              onPressed: () {},
              buttonType: ButtonVariants.twoColumn,
              isEnabled: false,
            ),
            SizedBox(
              height: size.size20.dp,
            ),
            TertiaryButton(
              caption: locale.txt(key: 'proceed'),
              isEnabled: false,
              onPressed: () {},
            ),
            SizedBox(
              height: size.size20.dp,
            ),
            TertiaryButton(
              caption: locale.txt(key: 'proceed'),
              onPressed: () {},
              leadingImagePath: 'images/IC_arrow_backword.svg',
              trailingImagePath: 'images/IC_arrow_forward_grey.svg',
              package: 'uikit',
            ),
            SizedBox(
              height: size.size20.dp,
            ),
            HyperlinkButton(
              labelFontSize: 20,
              caption: locale.txt(key: 'proceed'),
              onPressed: () {},
            ),
            SizedBox(
              height: size.size20.dp,
            ),
            HyperlinkButton(
              labelFontSize: 20,
              caption: locale.txt(key: 'proceed'),
              isEnabled: false,
              onPressed: () {},
            ),
            SizedBox(
              height: size.size20.dp,
            ),
            Row(
              children: [
                RoundButton(
                  onPressed: () {},
                  buttonVariant: ButtonVariants.circular,
                  iconPath: 'images/IC_arrow_forward_white.svg',
                  package: 'uikit',
                ),
                SizedBox(
                  width: size.size20.dp,
                ),
                RoundButton(
                  onPressed: () {},
                  buttonVariant: ButtonVariants.circular,
                  isEnabled: false,
                  iconPath: 'images/IC_arrow_forward_grey.svg',
                  package: 'uikit',
                ),
                SizedBox(
                  height: size.size20.dp,
                ),
              ],
            ),
            SizedBox(
              height: size.size20.dp,
            ),
            Row(
              children: [
                RoundButton(
                  onPressed: () {},
                  buttonVariant: ButtonVariants.circular,
                  iconPath: 'images/IC_arrow_backword.svg',
                  package: 'uikit',
                  buttonType: RoundedButtonType.borderlined,
                ),
                SizedBox(
                  width: size.size20.dp,
                ),
                RoundButton(
                  onPressed: () {},
                  buttonVariant: ButtonVariants.circular,
                  isEnabled: false,
                  iconPath: 'images/IC_arrow_forward_grey.svg',
                  package: 'uikit',
                ),
              ],
            ),
            SizedBox(
              height: size.size20.dp,
            ),
            Row(
              children: [
                ScheduleDateButton(
                  date: DateTime.now(),
                  // onTap: onTapDate,
                ),
                SizedBox(
                  width: size.size20.dp,
                ),
                ScheduleDateButton(
                  date: DateTime.now(),
                  // onTap: onTapDate,
                ),
                SizedBox(
                  width: size.size20.dp,
                ),
                ScheduleDateButton(
                  date: DateTime.now(),
                  isDisabled: true,
                  // onTap: onTapDate,
                ),
              ],
            ),
            SizedBox(
              height: size.size20.dp,
            ),
            ScheduleTimeButton(
              time: DateTime.now(),
              onTap: onTapTime,
            ),
            SizedBox(
              height: size.size20.dp,
            ),
            ScheduleTimeButton(
              time: DateTime.now(),
              onTap: onTapTime,
            ),
            SizedBox(
              height: size.size20.dp,
            ),
            ScheduleTimeButton(
              time: DateTime.now(),
              isDisabled: true,
              onTap: onTapTime,
            ),
            SizedBox(
              height: size.size20.dp,
            ),
          ],
        ),
      ),
    );
  }
}

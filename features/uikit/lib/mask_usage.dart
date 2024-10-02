import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/tcs_dff_design_system.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';
import 'package:tcs_dff_shared_library/localization/app_localizations.dart';
import 'package:tcs_dff_shared_library/masker/masker.dart';

class MaskUsageScreen extends StatefulWidget {
  const MaskUsageScreen({super.key});

  @override
  State<MaskUsageScreen> createState() => _MaskUsageScreenState();
}

class _MaskUsageScreenState extends State<MaskUsageScreen> {
  @override
  Widget build(final BuildContext context) {
    final textStyles = context.theme.appTextStyles;
    final color = context.theme.appColor;
    final locale = context.locale;
    return Scaffold(
      backgroundColor: context.theme.appColor.greyBlackUi10,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: context.theme.appSize.size30.dp),
            Text(
              locale.txt(
                key: 'maskTxt',
                args: {
                  'patternName': 'Aadhar Card',
                },
              ),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            TextWidget(
              text: Masker.doMask(
                originalText: '222244448888',
                maskType: MaskTypes.aadhar,
              ),
              style: textStyles.bodyCopy1Large18Bold
                  .copyWith(color: color.greyWhiteUi100),
            ),
            SizedBox(height: context.theme.appSize.size30.dp),
            Text(
              locale.txt(
                key: 'maskTxt',
                args: {
                  'patternName': 'Credit Card',
                },
              ),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            TextWidget(
              text: Masker.doMask(
                originalText: '1111222233334444',
                maskType: MaskTypes.creditCard,
              ),
              style: textStyles.bodyCopy1Large18Bold
                  .copyWith(color: color.greyWhiteUi100),
            ),
            SizedBox(height: context.theme.appSize.size30.dp),
            Text(
              locale.txt(
                key: 'maskTxt',
                args: {
                  'patternName': 'Mobile Number',
                },
              ),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            TextWidget(
              text: Masker.doMask(
                originalText: '91 0000111100',
                maskType: MaskTypes.mobileNumber,
              ),
              style: textStyles.bodyCopy1Large18Bold
                  .copyWith(color: color.greyWhiteUi100),
            ),
            SizedBox(height: context.theme.appSize.size30.dp),
            Text(
              locale.txt(
                key: 'maskTxt',
                args: {
                  'patternName': 'VID',
                },
              ),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            TextWidget(
              text: Masker.doMask(
                originalText: '1234567890123456',
                maskType: MaskTypes.vid,
              ),
              style: textStyles.bodyCopy1Large18Bold
                  .copyWith(color: color.greyWhiteUi100),
            ),
            SizedBox(height: context.theme.appSize.size30.dp),
            Text(
              locale.txt(
                key: 'maskTxt',
                args: {
                  'patternName': 'Custom',
                },
              ),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            TextWidget(
              text: Masker.doMask(
                originalText: '1234567890123456',
                maskType: MaskTypes.custom,
                customPattern: 'XXXX-XXXX-XXXX-XXXX',
              ),
              style: textStyles.bodyCopy1Large18Bold
                  .copyWith(color: color.greyWhiteUi100),
            ),
            TextWidget(
              text: Masker.doMask(
                originalText: '123qWEr45@6',
                maskType: MaskTypes.custom,
                customPattern: '##*#*###*##',
                maskedSymbol: '*',
              ),
              style: textStyles.bodyCopy1Large18Bold
                  .copyWith(color: color.greyWhiteUi100),
            ),
          ],
        ),
      ),
    );
  }
}

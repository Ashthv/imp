import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/tcs_dff_design_system.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';
import 'package:tcs_dff_shared_library/localization/app_localizations.dart';

class TitleSubtitleScreen extends StatelessWidget {
  const TitleSubtitleScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    final locale = context.locale;
    final size = context.theme.appSize;
    final color = context.theme.appColor;
    final textStyle = context.theme.appTextStyles;
    return Container(
      margin: EdgeInsets.all(size.size12.dp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleSubtitleTextWidget(
            title: locale.txt(key: 'title'),
            subtitle: locale.txt(key: 'subtitle'),
          ),
          SizedBox(
            height: size.size16.dp,
          ),
          TitleSubtitleTextWidget(
            title: locale.txt(key: 'title'),
            subtitle: '94511116990',
            titleTextStyle: textStyle.labelSmall14Medium.copyWith(
              color: color.clrPrimaryPurple20,
              fontWeight: FontWeight.w700,
              fontSize: size.size16.dp,
            ),
            subtitleTextStyle: textStyle.labelSmall14Medium.copyWith(
              color: color.greyDarkestGrey20,
              fontWeight: FontWeight.w400,
              fontSize: size.size14.dp,
            ),
            customPattern: 'XXXXXXX####',
          ),
          SizedBox(
            height: size.size16.dp,
          ),
          const TitleSubtitleTextWidget(
            titleFlex: 5,
            subTitleFlex: 2,
            verticalOrientation: false,
            title: 'Late Prompt Payment',
            subtitle: 'Rs. 10,000',
          ),
        ],
      ),
    );
  }
}

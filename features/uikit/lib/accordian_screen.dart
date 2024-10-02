import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/uikit/container/accordian.dart';
import 'package:tcs_dff_design_system/uikit/foundation/icon_widget.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';
import 'package:tcs_dff_shared_library/localization/app_localizations.dart';

class AccordianScreen extends StatefulWidget {
  const AccordianScreen({super.key});

  @override
  State<AccordianScreen> createState() => _AccordianScreenState();
}

class _AccordianScreenState extends State<AccordianScreen> {
  bool isExpanded = false;

  @override
  Widget build(final BuildContext context) {
    final textStyle = context.theme.appTextStyles;
    final color = context.theme.appColor;
    final size = context.theme.appSize;
    final locale = context.locale;

    return Padding(
      padding: EdgeInsets.only(
        top: size.size20.dp,
        right: size.size21.dp,
        left: size.size21.dp,
      ),
      child: Column(
        children: [
          Accordian(
            title: locale.txt(key: 'accordianTitle'),
            content: Column(
              children: [
                Text(
                  locale.txt(key: 'accordianContent'),
                  style: textStyle.bodyCopy2Small16Regular.copyWith(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    color: color.greyBlackUi10,
                  ),
                ),
              ],
            ),
            onExpanded: (final value) {
              setState(() {
                isExpanded = value;
              });
            },
            iconData: IconWidget(
              iconName: 'images/alarm_on.png',
              iconSize: IconSize.large,
              iconColor: isExpanded == true
                  ? color.clrPrimaryPurple
                  : color.greyGrey50,
            ), isDisabled: false,
          ),
          SizedBox(height: size.size10,),
          Accordian(
            title: locale.txt(key: 'accordianTitle'),
            content: Column(
              children: [
                Text(
                  locale.txt(key: 'accordianContent'),
                  style: textStyle.bodyCopy2Small16Regular.copyWith(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    color: color.greyBlackUi10,
                  ),
                ),
              ],
            ),
            onExpanded: (final value) {
              setState(() {
                isExpanded = value;
              });
            },
            iconData: IconWidget(
              iconName: 'images/alarm_on.png',
              iconSize: IconSize.large,
              iconColor: isExpanded == true
                  ? color.clrPrimaryPurple
                  : color.greyGrey50,
            ), isDisabled: true,
          ),
        ],
      ),
    );
  }
}

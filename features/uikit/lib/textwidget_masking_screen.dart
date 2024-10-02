import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/tcs_dff_design_system.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';

class TextWidgetMaskingScreen extends StatefulWidget {
  const TextWidgetMaskingScreen({super.key});

  @override
  State<TextWidgetMaskingScreen> createState() =>
      _TextWidgetMaskingScreenState();
}

class _TextWidgetMaskingScreenState extends State<TextWidgetMaskingScreen> {
  String maskingText = '₹94,51,11,990';
  String getCustomPattern(final String text) {
    final maskingPatternBuffer = StringBuffer();
    if (text[0] == '₹') {
      maskingPatternBuffer
        ..write('#')
        ..write('X' * (text.replaceAll(',', '').length - 1));
    } else {
      maskingPatternBuffer.write('X' * (text.replaceAll(',', '').length));
    }
    return maskingPatternBuffer.toString();
  }

  @override
  Widget build(final BuildContext context) {
    final color = context.theme.appColor;
    final size = context.theme.appSize;
    final textStyle = context.theme.appTextStyles;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextWidgetMasking(
            customPattern: 'XXXXXXX####',
            text: '94511116990',
          ),
          SizedBox(
            height: size.size10.dp,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextWidgetMasking(
                customPattern: getCustomPattern(maskingText),
                text: maskingText,
                textStyle: textStyle.h520pxMedium.copyWith(
                  color: color.greyFullBlack10,
                  fontSize: size.size20.sp,
                  height: 1.5,
                ),
                iconColor: color.greyFullBlack10,
                iconSize: size.size24.dp,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

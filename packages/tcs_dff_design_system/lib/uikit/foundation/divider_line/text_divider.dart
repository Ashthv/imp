import 'package:flutter/material.dart';

import '../../../tcs_dff_design_system.dart';
import '../../../theme/theme.dart';
import '../../../utils/sizer/app_sizer.dart';
import 'solid_divider.dart';

class TextDivider extends StatelessWidget {
  const TextDivider({
    super.key,
    this.text,
    this.height,
    this.color,
    this.thickness,
  });
  final String? text;
  final double? height;
  final Color? color;
  final double? thickness;

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final textStyle = context.theme.appTextStyles;
    final appColor = context.theme.appColor;

    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            margin: EdgeInsets.only(right: size.size4.dp),
            child: SolidDivider(
              color: color,
              height: height,
            ),
          ),
        ),
        TextWidget(
          text: text ?? '',
          style: textStyle.labelSmall14Medium.copyWith(
            color: color ?? appColor.greyLighterGrey70,
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: size.size4.dp),
            child: SolidDivider(
              color: color,
              height: height,
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../../../theme/theme.dart';
import '../../../utils/sizer/app_sizer.dart';
import 'dash_separator.dart';
import 'solid_divider.dart';
import 'text_divider.dart';

class DividerLine extends StatelessWidget {
  const DividerLine({
    this.dividerType,
    this.height,
    this.width,
    this.color,
    this.text,
  });
  final DividerType? dividerType;
  final double? height;
  final double? width;
  final Color? color;
  final String? text;

  @override
  Widget build(final BuildContext context) {
    final appColor = context.theme.appColor;
    final appSize = context.theme.appSize;

    if (dividerType != null &&
        (dividerType!.name == DividerType.dashDivider.name)) {
      return DashSeparator(
        dashWith: width ?? appSize.size8.dp,
        dashHeight: height ?? appSize.size1.dp,
        fillRate: appSize.size7.dp / appSize.size10.dp,
        dashColor: color ?? appColor.greyLighterGrey70,
      );
    } else if (dividerType != null &&
        (dividerType!.name == DividerType.solidDivider.name)) {
      return SolidDivider(
        thickness: height ?? appSize.size1.dp,
        color: color ?? appColor.greyLighterGrey70,
      );
    } else if (dividerType != null &&
        (dividerType!.name == DividerType.textDivider.name)) {
      return TextDivider(
        height: height ?? appSize.size1.dp,
        color: color ?? appColor.greyLighterGrey70,
        text: text,
      );
    }
    return SolidDivider(
      thickness: height ?? appSize.size1.dp,
      color: color ?? appColor.greyLighterGrey70,
    );
  }
}

enum DividerType {
  solidDivider,
  dashDivider,
  textDivider,
}

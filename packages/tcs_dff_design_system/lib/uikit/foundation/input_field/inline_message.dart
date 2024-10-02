import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import '../../../utils/sizer/app_sizer.dart';

class InlineMessage extends StatelessWidget {
  const InlineMessage({
    super.key,
    this.errorText,
    this.ecoFriendlyWidget,
    this.helperWidget,
  });
  final String? errorText;
  final Widget? ecoFriendlyWidget;
  final Widget? helperWidget;

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final color = context.theme.appColor;
    final textStyle = context.theme.appTextStyles;
    return Container(
      margin: EdgeInsets.only(top: size.size1.dp),
      padding: EdgeInsets.symmetric(
        horizontal: size.size10.dp,
        vertical: size.size3.dp,
      ),
      color: errorText != null
          ? color.statRedLightRed
          : ecoFriendlyWidget != null
              ? color.statLightGreen
              : helperWidget != null
                  ? color.clrPrimaryBlue110
                  : color.transparent,
      child: errorText != null
          ? Text(
              errorText!,
              style: textStyle.labelSmall14Medium.copyWith(
                fontSize: size.size14.sp,
                fontWeight: FontWeight.w400,
                color: color.statRedDark,
              ),
            )
          : ecoFriendlyWidget ?? (helperWidget ?? const SizedBox.shrink()),
    );
  }
}

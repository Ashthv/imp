import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class InactiveDateWidget extends StatelessWidget {
  InactiveDateWidget({
    super.key,
    required this.child,
    required this.calenderColorTheme,
  });
  final Object child;
  final CalenderColorTheme calenderColorTheme;
  @override
  Widget build(final BuildContext context) {
    final textStyle = context.theme.appTextStyles;

    return Container(
      alignment: Alignment.center,
      child: Text(
        child.toString(),
        style: textStyle.h316pxsemiBold.copyWith(
          color:calenderColorTheme.disabledDateFontColor,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

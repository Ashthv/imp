import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../theme/theme.dart';
import '../../../theme/theme_extensions/color_extension.dart';
import '../../../theme/theme_extensions/size_extension.dart';
import '../../../theme/theme_extensions/text_style_extension.dart';
import '../../../utils/sizer/app_sizer.dart';


class ScheduleTimeButton extends StatelessWidget {
  final bool isDisabled;
  final bool isSelected;
  final void Function(DateTime, bool)? onTap;
  final DateTime time;

  const ScheduleTimeButton({
    super.key,
    this.isDisabled = false,
    this.isSelected = false,
    this.onTap,
    required this.time,
  });

  Widget timeVariant(
    final AppSizeExtension size,
    final AppColorsExtension color,
    final AppTextStyleExtension textStyle,
  ) =>
      InkWell(
        onTap: isDisabled ? null : () => onTap!(time, isSelected),
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: size.size6.dp,
            horizontal: size.size8.dp,
          ),
          decoration: BoxDecoration(
            color: isDisabled
                ? color.greyOffWhite90
                : (isSelected == false)
                    ? color.greyWhiteUi100
                    : color.clrPrimaryPurple,
            border: Border.all(
              width: size.size2.dp,
              color: isDisabled
                  ? color.greyLightestGrey80
                  : (isSelected == false)
                      ? color.greyLightestGrey80
                      : color.clrPrimaryPurple,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(
                size.size8.dp,
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
                Text(
                  DateFormat('hh:mm a').format(time),
                  style: textStyle.h316pxsemiBold.copyWith(
                    fontSize: size.size16.dp,
                    fontWeight: FontWeight.w400,
                    color: isDisabled
                        ? color.greyLightestGrey80
                        : (isSelected == false)
                            ? color.greyDarkestGrey20
                            : color.greyFullWhite120,
                  ),
                ),
            ],
          ),
        ),
      );

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final color = context.theme.appColor;
    final textStyle = context.theme.appTextStyles;

    return timeVariant(size, color, textStyle);
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../theme/theme.dart';
import '../../../theme/theme_extensions/color_extension.dart';
import '../../../theme/theme_extensions/size_extension.dart';
import '../../../theme/theme_extensions/text_style_extension.dart';
import '../../../utils/sizer/app_sizer.dart';


class ScheduleDateButton extends StatelessWidget {
  final bool isDisabled;
  final bool isSelected;
  final void Function(DateTime, bool)? onTap;
  final DateTime date;

  const ScheduleDateButton({
    super.key,
    this.isDisabled = false,
    this.isSelected = false,
    this.onTap,
    required this.date,
  });

  Widget dayVariant(
    final AppSizeExtension size,
    final AppColorsExtension color,
    final AppTextStyleExtension textStyle,
  ) =>
      InkWell(
        onTap: isDisabled
            ? null
            : () {
                onTap!(
                  date,
                  isSelected,
                );
              },
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: size.size14.dp,
            horizontal: size.size24.dp,
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
            children: [
                Padding(
                  padding: EdgeInsets.only(
                    bottom: size.size6.dp,
                  ),
                  child: Text(
                    DateFormat('EEE').format(date),
                    style: textStyle.h316pxsemiBold.copyWith(
                      fontSize: size.size16.dp,
                      fontWeight: FontWeight.w500,
                      color: isDisabled
                          ? color.greyLightestGrey80
                          : (isSelected == false)
                              ? color.greyDarkestGrey20
                              : color.greyFullWhite120,
                    ),
                  ),
                ),
                Text(
                  DateFormat('dd').format(date),
                  style: textStyle.h316pxsemiBold.copyWith(
                    fontSize: size.size16.dp,
                    fontWeight: FontWeight.w500,
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

    return dayVariant(size, color, textStyle);
  }
}

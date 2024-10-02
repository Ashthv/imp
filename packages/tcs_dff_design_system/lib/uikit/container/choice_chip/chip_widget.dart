import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import '../../../utils/sizer/app_sizer.dart';

enum StatusCode {
  normal,
  suggested,
  disabled,
}

class ChipWidget extends StatefulWidget {
  final String label;
  final bool isSelected;
  final void Function(bool) onSelected;
  final StatusCode? staus;

  ChipWidget({
    super.key,
    required this.label,
    required this.isSelected,
    this.staus = StatusCode.normal,
    required this.onSelected,
  });

  @override
  State<ChipWidget> createState() => _ChoiceChipState();
}

class _ChoiceChipState extends State<ChipWidget> {
  @override
  Widget build(final BuildContext context) {
    final textStyle = context.theme.appTextStyles;
    final color = context.theme.appColor;
    final size = context.theme.appSize;

    return FilterChip(
      showCheckmark: false,
      onSelected: widget.onSelected,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: getBorderColor(context, widget.staus!)),
        borderRadius: BorderRadius.all(
          Radius.circular(size.size20.dp),
        ),
      ),
      label: Text(
        widget.label,
        style: textStyle.bodyCopy2Medium16SemiBold.copyWith(
          color: widget.isSelected
              ? color.greyWhiteUi100
              : getTextColor(context, widget.staus!),
        ),
      ),
      backgroundColor: widget.isSelected
          ? color.clrPrimaryPurple
          : getBgColor(context, widget.staus!),
    );
  }
}

Color getBgColor(final BuildContext context, final StatusCode statusCode) {
  final color = context.theme.appColor;

  switch (statusCode) {
    case StatusCode.normal:
      return color.clrPrimaryPurple120;
    case StatusCode.disabled:
      return color.greyOffWhite90;
    case StatusCode.suggested:
      return color.clrPrimaryPurple100;
    default:
      return color.clrPrimaryPurple120;
  }
}

Color getTextColor(final BuildContext context, final StatusCode statusCode) {
  final color = context.theme.appColor;
  switch (statusCode) {
    case StatusCode.normal:
      return color.greyBlackUi10;
    case StatusCode.disabled:
      return color.greyLighterGrey70;
    case StatusCode.suggested:
      return color.clrPrimaryPurple;

    default:
      return color.greyBlackUi10;
  }
}

Color getBorderColor(final BuildContext context, final StatusCode statusCode) {
  final color = context.theme.appColor;
  if (statusCode == StatusCode.suggested) {
    return color.clrPrimaryPurple;
  } else {
    return color.clrPrimaryPurple120;
  }
}

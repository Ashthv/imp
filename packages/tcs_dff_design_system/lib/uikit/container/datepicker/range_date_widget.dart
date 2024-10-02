import 'package:flutter/material.dart';
import '../../../theme/theme.dart';
import '../../../utils/sizer/app_sizer.dart';

class RangeDateWidget extends StatefulWidget {
  final Object child;
  final bool isSelected;
  final bool isEnabled;
  final AutocompleteOnSelected<Object> onSelected;
  final bool isInRange;
  final CalenderColorTheme calenderColorTheme;

  RangeDateWidget({
    super.key,
    required this.child,
    required this.isSelected,
    required this.onSelected,
    required this.isEnabled,
    required this.calenderColorTheme,
    this.isInRange = false,
  });

  @override
  State<RangeDateWidget> createState() => _RangeDateWidgetState();
}

class _RangeDateWidgetState extends State<RangeDateWidget> {
  @override
  Widget build(final BuildContext context) {
    final textStyle = context.theme.appTextStyles;
    final size = context.theme.appSize;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            if (widget.isEnabled) {
              setState(() {
                widget.onSelected(widget.child);
              });
            }
          },
          child: CircleAvatar(
            radius: size.size16.dp,
            backgroundColor: widget.isInRange
                ? widget.calenderColorTheme.rangeDateBgColor
                : widget.isSelected
                    ? widget.calenderColorTheme.selectedDateBgColor
                    : widget.calenderColorTheme.defaultDateBgColor,
            child: Text(
              widget.child.toString(),
              style: textStyle.h316pxsemiBold.copyWith(
                color: widget.isEnabled
                    ? (widget.isSelected
                        ? widget.calenderColorTheme.selectedDateFontColor
                        : widget.calenderColorTheme.defaultDateFontColor)
                    : widget.calenderColorTheme.disabledDateFontColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../../../theme/theme.dart';
import '../../../utils/sizer/app_sizer.dart';

class YearWidget extends StatefulWidget {
  const YearWidget({
    super.key,
    required this.child,
    required this.isSelected,
    required this.isEnabled,
    required this.onSelected,
    required this.calenderColorTheme,
  });
  final Object child;
  final bool isSelected;
  final bool isEnabled;
  final AutocompleteOnSelected<Object> onSelected;
  final CalenderColorTheme calenderColorTheme;

  @override
  State<YearWidget> createState() => _YearWidgetState();
}

class _YearWidgetState extends State<YearWidget> {
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
          child: Container(
            height: size.size35.dp,
            width: size.size88.dp,
            decoration: BoxDecoration(
              color: widget.isSelected
                  ? widget.calenderColorTheme.selectedYearBgColor
                  : widget.calenderColorTheme.defaultYearBgColor,
              borderRadius: BorderRadius.circular(size.size16.dp),
            ),
            child: Center(
              child: Text(
                widget.child.toString(),
                style: textStyle.h414pxRegular.copyWith(
                  color: widget.isEnabled
                      ? (widget.isSelected
                          ? widget.calenderColorTheme.selectedYearFontColor
                          : widget.calenderColorTheme.defaultYearFontColor)
                      : widget.calenderColorTheme.disabledYearFontColor,
                  fontWeight:
                      widget.isSelected ? FontWeight.w500 : FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

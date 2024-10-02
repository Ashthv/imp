import 'package:flutter/material.dart';
import '../../../theme/theme.dart';
import '../../../utils/sizer/app_sizer.dart';

class ActiveMonthWidget extends StatefulWidget {
  const ActiveMonthWidget({
    super.key,
    required this.child,
    required this.isSelected,
    required this.onSelected,
    required this.calenderColorTheme,
    
  });
  final Object child;
  final bool isSelected;
  final AutocompleteOnSelected<Object> onSelected;
  final CalenderColorTheme calenderColorTheme;

  @override
  State<ActiveMonthWidget> createState() => _ActiveMonthWidgetState();
}

class _ActiveMonthWidgetState extends State<ActiveMonthWidget> {
  @override
  Widget build(final BuildContext context) {
    final textStyle = context.theme.appTextStyles;
    final size = context.theme.appSize;

    return Row(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              widget.onSelected(widget.child);
            });
          },
          child: Container(
            height: size.size35.dp,
            width: size.size88.dp,
            decoration: BoxDecoration(
              color: widget.isSelected
                  ? widget.calenderColorTheme.selectedMonthBgColor
                  : widget.calenderColorTheme.defaultMonthBgColor,
              borderRadius: BorderRadius.circular(size.size16.dp),
            ),
            child: Center(
              child: Text(
                widget.child.toString(),
                style: textStyle.h414pxRegular.copyWith(
                  color: widget.isSelected
                      ? widget.calenderColorTheme.selectedMonthFontColor
                      : widget.calenderColorTheme.defaultMonthFontColor,
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

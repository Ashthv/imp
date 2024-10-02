import 'package:flutter/material.dart';
import '../../../theme/theme.dart';
import '../../../utils/sizer/app_sizer.dart';

class ActiveDateWidget extends StatefulWidget {
  const ActiveDateWidget({
    super.key,
    required this.child,
    required this.isSelected,
    required this.onSelected,
    required this.isEnabled,
    required this.calenderColorTheme,
  });
  final Object child;
  final bool isSelected;
  final bool isEnabled;
  final AutocompleteOnSelected<Object> onSelected;
  final CalenderColorTheme calenderColorTheme;

  @override
  State<ActiveDateWidget> createState() => _ActiveDateWidgetState();
}

class _ActiveDateWidgetState extends State<ActiveDateWidget> {
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
            backgroundColor: widget.isSelected
                ? widget.calenderColorTheme.selectedDateBgColor
                :  widget.calenderColorTheme.defaultDateBgColor,
            child: Text(
              widget.child.toString(),
              style: textStyle.h316pxsemiBold.copyWith(
                color: widget.isEnabled
                    ? (widget.isSelected
                        ? widget.calenderColorTheme.selectedDateFontColor
                        :widget.calenderColorTheme.defaultDateFontColor)
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

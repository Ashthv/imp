import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import '../../../utils/sizer/app_sizer.dart';
import 'active_month_widget.dart';

class MonthGridview extends StatefulWidget {
  MonthGridview({
    super.key,
    required this.initialSelectedMonth,
    required this.onChange,
    required this.months,
    required this.calenderColorTheme,
  });
  final int initialSelectedMonth;
  final ValueChanged<int> onChange;
  final List<String> months;
  final CalenderColorTheme calenderColorTheme;

  @override
  State<MonthGridview> createState() => _MonthGridviewState();
}

class _MonthGridviewState extends State<MonthGridview> {
  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    return Padding(
      padding: EdgeInsets.only(
        left: size.size18.dp,
        top: size.size26.dp,
        right: size.size18.dp,
        bottom: size.size40.dp,
      ),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisExtent: size.size35.dp,
          mainAxisSpacing: size.size24.dp,
          crossAxisSpacing: size.size24.dp,
        ),
        itemCount: widget.months.length,
        itemBuilder: (final BuildContext ctx, final index) => ActiveMonthWidget(
          child: widget.months[index],
          isSelected: index == widget.initialSelectedMonth - 1,
          onSelected: (final month) {
            setState(() {
              final selectedMonthValue =
                  widget.months.indexOf(month as String) + 1;
              widget.onChange(selectedMonthValue);
            });
          },
          calenderColorTheme: widget.calenderColorTheme,
        ),
      ),
    );
  }
}

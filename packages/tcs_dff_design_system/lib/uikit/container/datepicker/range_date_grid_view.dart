import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import '../../../theme/theme_extensions/size_extension.dart';
import '../../../utils/sizer/app_sizer.dart';
import 'inactive_date_widget.dart';
import 'range_date_widget.dart';

enum DateTypes {
  toDate,
  fromDate,
  date,
}

class RangeDateGridView extends StatefulWidget {
  final int initialSelectedDate;
  final int initialSelectedMonth;
  final int initialSelectedYear;
  final ValueChanged<int> onChange;
  final List<String> weekdays;
  final DateTime minSelectedDay;
  final DateTime maxSelectedDay;
  final DateTime? selectedStartDate;
  final DateTime? selectedEndDate;
  final CalenderColorTheme calenderColorTheme;

  const RangeDateGridView({
    super.key,
    required this.initialSelectedDate,
    required this.initialSelectedMonth,
    required this.initialSelectedYear,
    required this.minSelectedDay,
    required this.maxSelectedDay,
    required this.onChange,
    required this.weekdays,
    required this.calenderColorTheme,
    this.selectedStartDate,
    this.selectedEndDate,
  });

  @override
  State<RangeDateGridView> createState() => _RangeDateGridViewState();
}

class _RangeDateGridViewState extends State<RangeDateGridView> {
  int? weekdayWithMonthStarted;
  int? weekdayWithMonthEnd;
  int? daysInCurrentMonth;
  int? daysInPreviousMonth;
  static int _getDaysInMonth(final int year, final int month) {
    if (month == DateTime.february) {
      final isLeapYear =
          (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0);
      return isLeapYear ? 29 : 28;
    }
    const daysInMonth = <int>[31, -1, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    return daysInMonth[month - 1];
  }

  @override
  void initState() {
    super.initState();
    daysInCurrentMonth = _getDaysInMonth(
      widget.initialSelectedYear,
      widget.initialSelectedMonth,
    );
    daysInPreviousMonth = _getDaysInMonth(
      widget.initialSelectedYear,
      widget.initialSelectedMonth != 1 ? widget.initialSelectedMonth - 1 : 12,
    );
    weekdayWithMonthStarted = DateTime(
      widget.initialSelectedYear,
      widget.initialSelectedMonth,
    ).weekday;
    weekdayWithMonthEnd = DateTime(
      widget.initialSelectedYear,
      widget.initialSelectedMonth,
      daysInCurrentMonth!,
    ).weekday;
  }

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final textStyle = context.theme.appTextStyles;
    final color = context.theme.appColor;
    return Padding(
      padding: EdgeInsets.only(
        left: size.size17.dp,
        top: size.size10.dp,
        right: size.size17.dp,
        bottom: size.size14.dp,
      ),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          mainAxisSpacing: size.size6.dp,
          mainAxisExtent: size.size32.dp,
        ),
        // ignore: unnecessary_parenthesis
        itemCount: (7 +
            (weekdayWithMonthStarted! - 1) +
            daysInCurrentMonth! +
            (7 - weekdayWithMonthEnd!)),
        itemBuilder: (final BuildContext ctx, final index) {
          if (index <= 6) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: color.transparent,
                  width: 0.0.dp,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                widget.weekdays[index],
                style: textStyle.h414pxRegular.copyWith(
                  color: widget.calenderColorTheme.weekDayColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            );
          } else if (index <= 6 + (weekdayWithMonthStarted! - 1)) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: color.transparent,
                  width: 0.0.dp,
                ),
              ),
              child: InactiveDateWidget(
                child: (index - 7) +
                    daysInPreviousMonth! -
                    (weekdayWithMonthStarted! - 1) +
                    1,
                calenderColorTheme: widget.calenderColorTheme,
              ),
            );
          } else if (index <=
              6 + (weekdayWithMonthStarted! - 1) + daysInCurrentMonth!) {
            final isSelected = isDateSelected(index);
            final isInRange = isDateInRange(index);
            return Container(
              margin: isSelected.name == DateTypes.date.name
                  ? EdgeInsets.zero
                  : isSelected.name == DateTypes.fromDate.name
                      ? EdgeInsets.only(left: size.size12.dp)
                      : EdgeInsets.only(
                          right: size.size12.dp,
                        ),
              decoration: BoxDecoration(
                color: setBackgroundColor(
                  index,
                  isInRange,
                  DateTime(
                    widget.initialSelectedYear,
                    widget.initialSelectedMonth,
                    (index - 6) - (weekdayWithMonthStarted! - 1),
                  ),
                )
                    ? widget.calenderColorTheme.rangeDateBgColor
                    : color.transparent,
                border: Border.all(
                  color: isInRange ||
                          isSelected.name == DateTypes.fromDate.name ||
                          isSelected.name == DateTypes.toDate.name
                      ? widget.calenderColorTheme.rangeDateBgColor
                      : color.transparent,
                  width: 0.0.dp,
                ),
                borderRadius: getBorderRadius(
                  isInRange,
                  index,
                  isSelected,
                  size,
                  DateTime(
                    widget.initialSelectedYear,
                    widget.initialSelectedMonth,
                    (index - 6) - (weekdayWithMonthStarted! - 1),
                  ),
                ),
              ),
              child: RangeDateWidget(
                child: index - 6 - (weekdayWithMonthStarted! - 1),
                isEnabled: DateTime(
                      widget.initialSelectedYear,
                      widget.initialSelectedMonth,
                      index - 6 - (weekdayWithMonthStarted! - 1) + 1,
                    ).isAfter(widget.minSelectedDay) &&
                    DateTime(
                      widget.initialSelectedYear,
                      widget.initialSelectedMonth,
                      index - 6 - (weekdayWithMonthStarted! - 1),
                    ).isBefore(widget.maxSelectedDay),
                isSelected:
                    isSelected.name == DateTypes.date.name ? false : true,
                onSelected: (final date) {
                  setState(() {
                    final selectedDateValue = date as int;
                    widget.onChange(selectedDateValue);
                  });
                },
                isInRange: isInRange,
                calenderColorTheme: widget.calenderColorTheme,
              ),
            );
          } else {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: color.transparent,
                  width: 0.0.dp,
                ),
              ),
              child: InactiveDateWidget(
                child: (index - 6) -
                    weekdayWithMonthStarted! -
                    daysInCurrentMonth! +
                    1,
                calenderColorTheme: widget.calenderColorTheme,
              ),
            );
          }
        },
      ),
    );
  }

  DateTypes isDateSelected(final int index) {
    if (widget.selectedStartDate != null &&
        (index - 6) - (weekdayWithMonthStarted! - 1) ==
            widget.selectedStartDate!.day &&
        widget.initialSelectedMonth == widget.selectedStartDate!.month &&
        widget.initialSelectedYear == widget.selectedStartDate!.year) {
      return DateTypes.fromDate;
    } else if (widget.selectedEndDate != null &&
        (index - 6) - (weekdayWithMonthStarted! - 1) ==
            widget.selectedEndDate!.day &&
        widget.initialSelectedMonth == widget.selectedEndDate!.month &&
        widget.initialSelectedYear == widget.selectedEndDate!.year) {
      return DateTypes.toDate;
    }
    return DateTypes.date;
  }

  bool isDateInRange(final int index) {
    if (widget.selectedStartDate != null &&
        widget.selectedEndDate != null &&
        DateTime(
          widget.initialSelectedYear,
          widget.initialSelectedMonth,
          (index - 6) - (weekdayWithMonthStarted! - 1),
        ).isAfter(widget.selectedStartDate!) &&
        DateTime(
          widget.initialSelectedYear,
          widget.initialSelectedMonth,
          (index - 6) - (weekdayWithMonthStarted! - 1),
        ).isBefore(widget.selectedEndDate!)) {
      return true;
    }
    return false;
  }

  bool setBackgroundColor(
    final int index,
    final bool isInRange,
    final DateTime date,
  ) {
    if (widget.selectedStartDate != null && widget.selectedEndDate != null) {
      if (isInRange) {
        return true;
      } else if (date.isAtSameMomentAs(widget.selectedStartDate!) &&
          date.weekday != DateTime.sunday) {
        return true;
      } else if (date.isAtSameMomentAs(widget.selectedEndDate!) &&
          date.weekday != DateTime.monday) {
        return true;
      }
    }
    return false;
  }

  BorderRadius? getBorderRadius(
    final bool isInRange,
    final int index,
    final DateTypes isSelected,
    final AppSizeExtension size,
    final DateTime date,
  ) {
    if (widget.selectedStartDate != null && widget.selectedEndDate != null) {
      if (date.weekday == DateTime.monday &&
          (isSelected.name == DateTypes.fromDate.name || isInRange)) {
        return BorderRadius.horizontal(
          left: Radius.circular(size.size32.dp),
        );
      } else if ((date.weekday == DateTime.sunday) &&
          (isSelected.name == DateTypes.toDate.name || isInRange)) {
        return BorderRadius.horizontal(
          right: Radius.circular(size.size32.dp),
        );
      } else if (isSelected.name == DateTypes.date.name) {
        return const BorderRadius.only();
      } else if (isSelected.name == DateTypes.fromDate.name) {
        return BorderRadius.horizontal(
          left: Radius.circular(size.size32.dp),
        );
      } else {
        return BorderRadius.horizontal(
          right: Radius.circular(size.size32.dp),
        );
      }
    } else {
      return null;
    }
  }
}

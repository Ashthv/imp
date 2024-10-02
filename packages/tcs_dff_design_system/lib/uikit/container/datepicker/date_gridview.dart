import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import '../../../utils/sizer/app_sizer.dart';
import 'active_date_widget.dart';
import 'inactive_date_widget.dart';

class DateGridview extends StatefulWidget {
  const DateGridview({
    super.key,
    required this.initialSelectedDate,
    required this.initialSelectedMonth,
    required this.initialSelectedYear,
    required this.minSelectedDay,
    required this.maxSelectedDay,
    required this.onChange,
    required this.weekdays,
    required this.initialSelectedCalenderDate,
    required this.calenderColorTheme,
  });
  final int initialSelectedDate;
  final int initialSelectedMonth;
  final int initialSelectedYear;
  final ValueChanged<int> onChange;
  final List<String> weekdays;
  final DateTime minSelectedDay;
  final DateTime maxSelectedDay;
  final DateTime initialSelectedCalenderDate;
  final CalenderColorTheme calenderColorTheme;
  @override
  State<DateGridview> createState() => _DateGridviewState();
}

class _DateGridviewState extends State<DateGridview> {
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
          mainAxisExtent: size.size32.dp,
          mainAxisSpacing: size.size6.dp,
          crossAxisSpacing: size.size5.dp,
        ),
        // ignore: unnecessary_parenthesis
        itemCount: (7 +
            (weekdayWithMonthStarted! - 1) +
            daysInCurrentMonth! +
            (7 - weekdayWithMonthEnd!)),
        itemBuilder: (final BuildContext ctx, final index) {
          if (index <= 6) {
            return Container(
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
            return InactiveDateWidget(
              child: (index - 7) +
                  daysInPreviousMonth! -
                  (weekdayWithMonthStarted! - 1) +
                  1,
                  calenderColorTheme: widget.calenderColorTheme,
            );
          } else if (index <=
              6 + (weekdayWithMonthStarted! - 1) + daysInCurrentMonth!) {
            return ActiveDateWidget(
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
              isSelected: (index - 6) - (weekdayWithMonthStarted! - 1) ==
                      widget.initialSelectedDate &&
                  widget.initialSelectedMonth ==
                      widget.initialSelectedCalenderDate.month &&
                  widget.initialSelectedYear ==
                      widget.initialSelectedCalenderDate.year,
              onSelected: (final date) {
                setState(() {
                  final selectedDateValue = date as int;
                  widget.onChange(selectedDateValue);
                });
              },
              calenderColorTheme: widget.calenderColorTheme,
            );
          } else {
            return InactiveDateWidget(
              child: (index - 6) -
                  weekdayWithMonthStarted! -
                  daysInCurrentMonth! +
                  1,
             calenderColorTheme: widget.calenderColorTheme,
            );
          }
        },
      ),
    );
  }
}

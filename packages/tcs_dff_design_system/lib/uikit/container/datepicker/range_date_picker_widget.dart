import 'package:flutter/material.dart';
import '../../../theme/theme.dart';
import '../../../utils/image_type.dart';
import '../../../utils/sizer/app_sizer.dart';
import '../image/image_widget.dart';
import 'calendar_labels.dart';
import 'month_gridview.dart';
import 'range_date_grid_view.dart';
import 'year_gridview.dart';

class RangeDatePickerWidget extends StatefulWidget {
  final DateTime minSelectedDate;
  final DateTime maxSelectedDate;
  final CalendarLabels calendarLabels;
  final DateTime? selectedStartDate;
  final DateTime? selectedEndDate;
  final Function(DateTime?, DateTime?) onChange;
  final CalenderThemeType calenderTheme;

  RangeDatePickerWidget({
    super.key,
    required this.minSelectedDate,
    required this.maxSelectedDate,
    required this.calendarLabels,
    this.selectedStartDate,
    this.selectedEndDate,
    required this.onChange,
    this.calenderTheme = CalenderThemeType.dark,
  });

  @override
  State<RangeDatePickerWidget> createState() => _RangeDatePickerWidgetState();
}

class _RangeDatePickerWidgetState extends State<RangeDatePickerWidget> {
  bool isDatesShowing = true;
  bool isMonthsShowing = false;
  bool isYearsShowing = false;
  int? selectedDateValue;
  int? selectedMonthValue;
  int? selectedYearValue;
  late DateTime calendarStartDate;
  late DateTime calendarEndDate;
  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;
  late CalenderColorTheme _calenderColorTheme;

  void monthShowing() {
    setState(() {
      if (isMonthsShowing) {
        isDatesShowing = true;
        isMonthsShowing = false;
        isYearsShowing = false;
      } else {
        isDatesShowing = false;
        isMonthsShowing = true;
        isYearsShowing = false;
      }
    });
  }

  void yearShowing() {
    setState(() {
      if (isYearsShowing) {
        isDatesShowing = true;
        isMonthsShowing = false;
        isYearsShowing = false;
      } else {
        isDatesShowing = false;
        isMonthsShowing = false;
        isYearsShowing = true;
      }
    });
  }

  @override
  void initState() {
    if (widget.selectedStartDate != null) {
      selectedDateValue = widget.selectedStartDate!.day;
      selectedMonthValue = widget.selectedStartDate!.month;
      selectedYearValue = widget.selectedStartDate!.year;
    } else {
      final currentDate = DateTime.now();
      selectedDateValue = currentDate.day;
      selectedMonthValue = currentDate.month;
      selectedYearValue = currentDate.year;
    }
    _selectedStartDate = widget.selectedStartDate;
    _selectedEndDate = widget.selectedEndDate;
    calendarStartDate = DateTime(widget.minSelectedDate.year - 100);
    calendarEndDate = DateTime(widget.maxSelectedDate.year + 100, 12);
    _calenderColorTheme =
        CalenderColorTheme(calenderThemeType: widget.calenderTheme);
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final textStyle = context.theme.appTextStyles;
    return Container(
      height: size.size340.dp,
      width: size.size348.dp,
      decoration: BoxDecoration(
        color: _calenderColorTheme.titleBackgroundColor,
        borderRadius: BorderRadius.circular(size.size16.dp),
        border: Border.all(
          color: _calenderColorTheme.titleBackgroundColor,
          width: size.size3.dp,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
      ),
      child: Column(
        children: [
          Container(
            height: size.size56.dp,
            width: size.size348.dp,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: isMonthsShowing
                          ? _calenderColorTheme.backgroundColor
                          : _calenderColorTheme.titleBackgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(size.size16.dp),
                        topRight: Radius.circular(size.size16.dp),
                      ),
                    ),
                    child: InkWell(
                      onTap: monthShowing,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.calendarLabels
                                .monthFullNames[selectedMonthValue! - 1],
                            style: textStyle.h520pxMedium.copyWith(
                              color: _calenderColorTheme.fontColor,
                              fontSize: size.size20.sp,
                              fontWeight: isMonthsShowing
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                            ),
                          ),
                          IconButton(
                            onPressed: monthShowing,
                            icon: isMonthsShowing
                                ? ImageWidget(
                                    imageType: ImageType.assetImage,
                                    path: 'assets/images/keyboard_arrow_up.svg',
                                    color: _calenderColorTheme.iconColor,
                                    package: 'tcs_dff_design_system',
                                  )
                                : ImageWidget(
                                    imageType: ImageType.assetImage,
                                    path:
                                        'assets/images/keyboard_arrow_down.svg',
                                    color: _calenderColorTheme.iconColor,
                                    package: 'tcs_dff_design_system',
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.size30.dp,
                  child: VerticalDivider(
                    width: 0.5,
                    thickness: 0.5,
                    color: _calenderColorTheme.verticalDividerColor,
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: isYearsShowing
                          ? _calenderColorTheme.backgroundColor
                          : _calenderColorTheme.titleBackgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(size.size16.dp),
                        topRight: Radius.circular(size.size16.dp),
                      ),
                    ),
                    child: InkWell(
                      onTap: yearShowing,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            selectedYearValue!.toString(),
                            style: textStyle.h520pxMedium.copyWith(
                              color: _calenderColorTheme.fontColor,
                              fontSize: size.size20.sp,
                              fontWeight: isMonthsShowing
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                            ),
                          ),
                          IconButton(
                            onPressed: yearShowing,
                            icon: isYearsShowing
                                ? ImageWidget(
                                    imageType: ImageType.assetImage,
                                    path: 'assets/images/keyboard_arrow_up.svg',
                                    color: _calenderColorTheme.iconColor,
                                    package: 'tcs_dff_design_system',
                                  )
                                : ImageWidget(
                                    imageType: ImageType.assetImage,
                                    path:
                                        'assets/images/keyboard_arrow_down.svg',
                                    color: _calenderColorTheme.iconColor,
                                    package: 'tcs_dff_design_system',
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: size.size284.dp,
            width: size.size348.dp,
            decoration: BoxDecoration(
              color: _calenderColorTheme.backgroundColor,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(
                  size.size16.dp,
                ),
              ),
            ),
            child: isDatesShowing
                ? RangeDateGridView(
                    weekdays: widget.calendarLabels.weekdays,
                    initialSelectedDate: selectedDateValue!,
                    initialSelectedMonth: selectedMonthValue!,
                    initialSelectedYear: selectedYearValue!,
                    minSelectedDay: widget.minSelectedDate,
                    maxSelectedDay: widget.maxSelectedDate,
                    selectedStartDate: _selectedStartDate,
                    selectedEndDate: _selectedEndDate,
                    onChange: onDateChange,
                    calenderColorTheme: _calenderColorTheme,
                  )
                : isMonthsShowing
                    ? MonthGridview(
                        months: widget.calendarLabels.monthShortNames,
                        initialSelectedMonth: selectedMonthValue!,
                        onChange: (final month) {
                          setState(() {
                            selectedMonthValue = month;
                            isDatesShowing = true;
                            isMonthsShowing = false;
                          });
                        },
                        calenderColorTheme: _calenderColorTheme,
                      )
                    : YearGridview(
                        calendarStartYear: calendarStartDate.year,
                        calendarEndYear: calendarEndDate.year,
                        minSelectedYear: widget.minSelectedDate.year,
                        maxSelectedYear: widget.maxSelectedDate.year,
                        initialSelectedYear: selectedYearValue!,
                        onChange: (final year) {
                          setState(() {
                            selectedYearValue = year;
                            isMonthsShowing = true;
                            isYearsShowing = false;
                          });
                        },
                        calenderColorTheme: _calenderColorTheme,
                      ),
          ),
        ],
      ),
    );
  }

  void onDateChange(final int date) {
    setState(() {
      if (_selectedStartDate == null) {
        if (_selectedEndDate != null &&
            DateTime(
              selectedYearValue!,
              selectedMonthValue!,
              date,
            ).isAfter(_selectedEndDate!)) {
          _selectedStartDate = _selectedEndDate;
          selectedDateValue = _selectedStartDate!.day;
          _selectedEndDate = DateTime(
            selectedYearValue!,
            selectedMonthValue!,
            date,
          );
        } else {
          selectedDateValue = date;
          _selectedStartDate = DateTime(
            selectedYearValue!,
            selectedMonthValue!,
            date,
          );
        }
      } else if (_selectedEndDate == null) {
        if (_selectedStartDate!.isAtSameMomentAs(
          DateTime(
            selectedYearValue!,
            selectedMonthValue!,
            date,
          ),
        )) {
          _selectedStartDate = null;
        } else if (_selectedStartDate != null &&
            DateTime(
              selectedYearValue!,
              selectedMonthValue!,
              date,
            ).isBefore(_selectedStartDate!)) {
          _selectedEndDate = _selectedStartDate;
          _selectedStartDate = DateTime(
            selectedYearValue!,
            selectedMonthValue!,
            date,
          );
          selectedDateValue = _selectedStartDate!.day;
        } else {
          _selectedEndDate = DateTime(
            selectedYearValue!,
            selectedMonthValue!,
            date,
          );
        }
      } else if (DateTime(
        selectedYearValue!,
        selectedMonthValue!,
        date,
      ).isAtSameMomentAs(_selectedStartDate!)) {
        _selectedStartDate = null;
      } else if (DateTime(
        selectedYearValue!,
        selectedMonthValue!,
        date,
      ).isAtSameMomentAs(_selectedEndDate!)) {
        _selectedEndDate = null;
      } else if (DateTime(
        selectedYearValue!,
        selectedMonthValue!,
        date,
      ).isAfter(_selectedStartDate!)) {
        _selectedEndDate = DateTime(
          selectedYearValue!,
          selectedMonthValue!,
          date,
        );
      } else if (DateTime(
        selectedYearValue!,
        selectedMonthValue!,
        date,
      ).isBefore(_selectedStartDate!)) {
        selectedDateValue = date;
        _selectedStartDate = DateTime(
          selectedYearValue!,
          selectedMonthValue!,
          date,
        );
      }
      widget.onChange(
        _selectedStartDate,
        _selectedEndDate,
      );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/tcs_dff_design_system.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/uikit/container/datepicker/calendar_labels.dart';
import 'package:tcs_dff_design_system/uikit/foundation/input_field/date_text_formatter.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';
import 'package:tcs_dff_shared_library/localization/app_localizations.dart';
import 'package:tcs_dff_shared_library/validators/validators.dart';

class DatePickerScreen extends StatefulWidget {
  const DatePickerScreen({super.key});

  @override
  State<DatePickerScreen> createState() => _DatePickerScreenState();
}

class _DatePickerScreenState extends State<DatePickerScreen> {
  TextEditingController dateTextController = TextEditingController();
  TextEditingController fromDateTextController = TextEditingController();
  TextEditingController toDateTextController = TextEditingController();
  bool isCalenderOpen = false;
  bool isRangeDatePickerOpen = false;
  final FocusNode _focusNode = FocusNode();
  final FocusNode _fromDatePickerFocusNode = FocusNode();
  final FocusNode _toDatePickerFocusNode = FocusNode();

  final _datePickerKey = GlobalKey<FormFieldState>();

  String _label = 'Valid till';
  DateTime? _selectedDate, _fromDate, _toDate;
  String randomKey = 'calendar1', rangeDatePickerKey = 'calender2';
  List<String> getWeekdays(final BuildContext context) {
    final locale = context.locale;
    return [
      locale.txt(key: 'mon'),
      locale.txt(key: 'tue'),
      locale.txt(key: 'wed'),
      locale.txt(key: 'thu'),
      locale.txt(key: 'fri'),
      locale.txt(key: 'sat'),
      locale.txt(key: 'sun'),
    ];
  }

  List<String> getMonthShortNames(final BuildContext context) {
    final locale = context.locale;
    return [
      locale.txt(key: 'jan'),
      locale.txt(key: 'feb'),
      locale.txt(key: 'mar'),
      locale.txt(key: 'apr'),
      locale.txt(key: 'may'),
      locale.txt(key: 'jun'),
      locale.txt(key: 'jul'),
      locale.txt(key: 'aug'),
      locale.txt(key: 'sep'),
      locale.txt(key: 'oct'),
      locale.txt(key: 'nov'),
      locale.txt(key: 'dec'),
    ];
  }

  List<String> getMonthFullNames(final BuildContext context) {
    final locale = context.locale;
    return [
      locale.txt(key: 'january'),
      locale.txt(key: 'february'),
      locale.txt(key: 'march'),
      locale.txt(key: 'april'),
      locale.txt(key: 'may'),
      locale.txt(key: 'june'),
      locale.txt(key: 'july'),
      locale.txt(key: 'august'),
      locale.txt(key: 'september'),
      locale.txt(key: 'october'),
      locale.txt(key: 'november'),
      locale.txt(key: 'december'),
    ];
  }

  String changeDateTimeFormat(final DateTime? date) {
    if (date == null) {
      return '';
    } else {
      return '${date.day.toString().padLeft(2, "0")}/${date.month.toString().padLeft(2, "0")}/${date.year}';
    }
  }

  @override
  void initState() {
    super.initState();
    dateTextController.text = changeDateTimeFormat(_selectedDate);
    fromDateTextController.text = changeDateTimeFormat(_fromDate);
    toDateTextController.text = changeDateTimeFormat(_toDate);

    _label = '$_label (DD/MM/YY)';
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          _label = 'Valid till';
          isCalenderOpen = false;
          isRangeDatePickerOpen = false;
        });
      } else {
        setState(() {
          _label = '$_label (DD/MM/YY)';
        });
      }
    });

    _fromDatePickerFocusNode.addListener(() {
      if (_fromDatePickerFocusNode.hasFocus) {
        setState(() {
          isCalenderOpen = false;
          isRangeDatePickerOpen = false;
        });
      } else {
        setState(() {});
      }
    });

    _toDatePickerFocusNode.addListener(() {
      if (_toDatePickerFocusNode.hasFocus) {
        setState(() {
          isCalenderOpen = false;
          isRangeDatePickerOpen = false;
        });
      } else {
        setState(() {});
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isCalenderOpen) {
      WidgetsBinding.instance.addPostFrameCallback((final _) {
        Scrollable.ensureVisible(
          GlobalObjectKey(randomKey).currentContext!,
        );
      });
    } else if (isRangeDatePickerOpen) {
      WidgetsBinding.instance.addPostFrameCallback((final _) {
        Scrollable.ensureVisible(
          GlobalObjectKey(rangeDatePickerKey).currentContext!,
        );
      });
    }
  }

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final color = context.theme.appColor;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: size.size0.dp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFieldWidget(
                fieldKey: _datePickerKey,
                label: _label,
                controller: dateTextController,
                focusNode: _focusNode,
                hintText: 'DD/MM/YYYY',
                inputType: TextInputType.number,
                textFieldtypeText: 'Optional',
                inputFormatters: [
                  DateTextFormatter(),
                ],
                validators: [DateValidator(errorText: 'Enter valid date')],
                suffixWidget: Container(
                  height: size.size24.dp,
                  width: size.size24.dp,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isCalenderOpen = !isCalenderOpen;
                      });
                      didChangeDependencies();
                    },
                    child: ImageWidget(
                      imageType: ImageType.assetImage,
                      path: 'images/calendar.svg',
                      package: 'uikit',
                      color: color.clrPrimaryBlue10,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: isCalenderOpen,
                child: CalendarWidget(
                  key: GlobalObjectKey(randomKey),
                  calendarLabels: CalendarLabels(
                    weekdays: getWeekdays(context),
                    monthFullNames: getMonthFullNames(context),
                    monthShortNames: getMonthShortNames(context),
                  ),
                  minSelectedDate: DateTime(2000),
                  maxSelectedDate: DateTime.now(),
                  userSelectedDate: _selectedDate,
                  onChange: (final DateTime value) {
                    setState(() {
                      _selectedDate = value;
                      dateTextController.text =
                          changeDateTimeFormat(_selectedDate);
                      isCalenderOpen = false;
                      _datePickerKey.currentState
                          ?.didChange(dateTextController.text);
                    });
                  },
                ),
              ),
              SizedBox(
                height: size.size24.dp,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFieldWidget(
                      label: 'From',
                      controller: fromDateTextController,
                      focusNode: _fromDatePickerFocusNode,
                      hintText: 'DD/MM/YYYY',
                      inputType: TextInputType.number,
                      inputFormatters: [
                        DateTextFormatter(),
                      ],
                      suffixWidget: Container(
                        height: size.size24.dp,
                        width: size.size24.dp,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isRangeDatePickerOpen = !isRangeDatePickerOpen;
                            });
                            didChangeDependencies();
                          },
                          child: ImageWidget(
                            imageType: ImageType.assetImage,
                            path: 'images/calendar.svg',
                            package: 'uikit',
                            color: color.clrPrimaryBlue10,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: TextFieldWidget(
                      label: 'To',
                      controller: toDateTextController,
                      focusNode: _toDatePickerFocusNode,
                      hintText: 'DD/MM/YYYY',
                      inputType: TextInputType.number,
                      inputFormatters: [
                        DateTextFormatter(),
                      ],
                      suffixWidget: Container(
                        height: size.size24.dp,
                        width: size.size24.dp,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isRangeDatePickerOpen = !isRangeDatePickerOpen;
                            });
                            didChangeDependencies();
                          },
                          child: ImageWidget(
                            imageType: ImageType.assetImage,
                            path: 'images/calendar.svg',
                            package: 'uikit',
                            color: color.clrPrimaryBlue10,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: isRangeDatePickerOpen,
                child: RangeDatePickerWidget(
                  calenderTheme: CalenderThemeType.light,
                  key: GlobalObjectKey(rangeDatePickerKey),
                  calendarLabels: CalendarLabels(
                    weekdays: getWeekdays(context),
                    monthFullNames: getMonthFullNames(context),
                    monthShortNames: getMonthShortNames(context),
                  ),
                  minSelectedDate: DateTime(2000),
                  maxSelectedDate: DateTime.now(),
                  selectedStartDate: _fromDate,
                  selectedEndDate: _toDate,
                  onChange: (final fromDate, final toDate) {
                    setState(() {
                      _toDate = toDate;
                      _fromDate = fromDate;
                      toDateTextController.text = changeDateTimeFormat(toDate);
                      fromDateTextController.text =
                          changeDateTimeFormat(fromDate);
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

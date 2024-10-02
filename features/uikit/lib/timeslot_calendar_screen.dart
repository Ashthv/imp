import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/tcs_dff_design_system.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';

class TimeSlotCalendarScreen extends StatefulWidget {
  const TimeSlotCalendarScreen({super.key});

  @override
  State<TimeSlotCalendarScreen> createState() => _TimeSlotCalendarScreenState();
}

class _TimeSlotCalendarScreenState extends State<TimeSlotCalendarScreen> {
  List<ScheduleTimeButtonItem> timeArray = [
    ScheduleTimeButtonItem(
      DateTime.parse('2024-05-15T12:00:00Z'),
      false,
      false,
    ),
    ScheduleTimeButtonItem(
      DateTime.parse('2024-05-15T10:00:00Z'),
      false,
      false,
    ),
    ScheduleTimeButtonItem(DateTime.parse('2024-05-15T10:00:00Z'), false, true),
    ScheduleTimeButtonItem(
      DateTime.parse('2024-05-15T10:00:00Z'),
      false,
      false,
    ),
    ScheduleTimeButtonItem(
      DateTime.parse('2024-05-15T10:00:00Z'),
      false,
      false,
    ),
    ScheduleTimeButtonItem(
      DateTime.parse('2024-05-15T10:00:00Z'),
      false,
      false,
    ),
    ScheduleTimeButtonItem(
      DateTime.parse('2024-05-15T10:00:00Z'),
      false,
      false,
    ),
    ScheduleTimeButtonItem(
      DateTime.parse('2024-05-15T10:00:00Z'),
      false,
      false,
    ),
    ScheduleTimeButtonItem(
      DateTime.parse('2024-05-15T10:00:00Z'),
      false,
      false,
    ),
    ScheduleTimeButtonItem(
      DateTime.parse('2024-05-15T10:00:00Z'),
      false,
      false,
    ),
    ScheduleTimeButtonItem(
      DateTime.parse('2024-05-15T10:00:00Z'),
      false,
      false,
    ),
    ScheduleTimeButtonItem(
      DateTime.parse('2024-05-15T10:00:00Z'),
      false,
      false,
    ),
    ScheduleTimeButtonItem(
      DateTime.parse('2024-05-15T10:00:00Z'),
      false,
      false,
    ),
    ScheduleTimeButtonItem(
      DateTime.parse('2024-05-15T10:00:00Z'),
      false,
      false,
    ),
    ScheduleTimeButtonItem(
      DateTime.parse('2024-05-15T10:00:00Z'),
      false,
      false,
    ),
    ScheduleTimeButtonItem(
      DateTime.parse('2024-05-15T10:00:00Z'),
      false,
      false,
    ),
    ScheduleTimeButtonItem(
      DateTime.parse('2024-05-15T10:00:00Z'),
      false,
      false,
    ),
  ];

  List<ScheduleDateButtonItem> dataArray = [
    ScheduleDateButtonItem(
      DateTime.parse('2024-05-12T12:00:00Z'),
      false,
      false,
    ),
    ScheduleDateButtonItem(
      DateTime.parse('2024-05-13T12:00:00Z'),
      false,
      false,
    ),
    ScheduleDateButtonItem(DateTime.parse('2024-05-14T12:00:00Z'), false, true),
    ScheduleDateButtonItem(
      DateTime.parse('2024-05-15T12:00:00Z'),
      false,
      false,
    ),
    ScheduleDateButtonItem(
      DateTime.parse('2024-05-16T12:00:00Z'),
      false,
      false,
    ),
    ScheduleDateButtonItem(
      DateTime.parse('2024-05-17T12:00:00Z'),
      false,
      false,
    ),
    ScheduleDateButtonItem(
      DateTime.parse('2024-05-12T12:00:00Z'),
      false,
      false,
    ),
  ];
  int initDateSelected = -1; // to store the position of last selected button
  int initTimeSelected = -1;
  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: size.size20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: MediaQuery.of(context).size.height *
                  (size.size12.dp /
                      size.size100
                          .dp), // change this proportion as per your need
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: dataArray.length,
                shrinkWrap: true,
                itemBuilder: (final context, final index) => Padding(
                  padding: EdgeInsets.only(
                    right: size.size20.dp,
                  ),
                  child: ScheduleDateButton(
                    date: dataArray[index].date,
                    isSelected: dataArray[index].isSelected,
                    isDisabled: dataArray[index].isDisabled,
                    onTap: (final date, final isSel) {
                      if (!isSel) {
                        setState(() {
                          dataArray[index].isSelected = true;
                          if (initDateSelected >= 0) {
                            dataArray[initDateSelected].isSelected = false;
                          }
                          initDateSelected =
                              index; // storing the value as last selected
                        });
                      } else {
                        // to stop getting callback when de-selecting the button
                        setState(() {
                          dataArray[index].isSelected = false;
                          initDateSelected = -1;
                        });
                      }
                    },
                  ),
                ),
              ),
            ),
            Wrap(
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: size.size3.toInt(),
                    childAspectRatio: size.size2.dp,
                    mainAxisSpacing: size.size10.dp,
                    crossAxisSpacing: size.size10.dp,
                  ),
                  itemCount: timeArray.length,
                  itemBuilder: (final context, final index) =>
                      ScheduleTimeButton(
                    time: timeArray[index].time,
                    isSelected: timeArray[index].isSelected,
                    isDisabled: timeArray[index].isDisabled,
                    onTap: (final DateTime time, final bool isClicked) {
                      if (!isClicked) {
                        setState(() {
                          timeArray[index].isSelected = true;
                          if (initTimeSelected >= 0) {
                            timeArray[initTimeSelected].isSelected = false;
                          }
                          initTimeSelected =
                              index; // storing the value as last selected
                        });
                      } else {
                        // to stop getting callback when de-selecting the button
                        setState(() {
                          timeArray[index].isSelected = false;
                          initTimeSelected = -1;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ScheduleDateButtonItem {
  DateTime date;
  bool isSelected;
  bool isDisabled;

  ScheduleDateButtonItem(
    this.date,
    this.isSelected,
    this.isDisabled,
  );
}

class ScheduleTimeButtonItem {
  DateTime time;
  bool isSelected;
  bool isDisabled;

  ScheduleTimeButtonItem(
    this.time,
    this.isSelected,
    this.isDisabled,
  );
}

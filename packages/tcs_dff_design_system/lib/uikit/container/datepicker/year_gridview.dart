import 'package:flutter/material.dart';
import '../../../theme/theme.dart';
import '../../../utils/image_type.dart';
import '../../../utils/sizer/app_sizer.dart';
import '../image/image_widget.dart';
import 'year_widget.dart';

class YearGridview extends StatefulWidget {
  const YearGridview({
    super.key,
    required this.calendarStartYear,
    required this.calendarEndYear,
    required this.initialSelectedYear,
    required this.minSelectedYear,
    required this.maxSelectedYear,
    required this.onChange,
    required this.calenderColorTheme,
    
  });
  final int calendarStartYear;
  final int calendarEndYear;
  final int initialSelectedYear;
  final ValueChanged<int> onChange;
  final int minSelectedYear;
  final int maxSelectedYear;
  final CalenderColorTheme calenderColorTheme;

  @override
  State<YearGridview> createState() => _YearGridviewState();
}

class _YearGridviewState extends State<YearGridview> {
  late ScrollController _scrollController;
  late int currentPageIndex;
  late int noOfPreviousPages;
  @override
  void initState() {
    super.initState();
    noOfPreviousPages =
        (widget.initialSelectedYear - widget.calendarStartYear) ~/ 12;
    currentPageIndex = noOfPreviousPages * 12 + 1;
    WidgetsBinding.instance.addPostFrameCallback((final _) {
      Scrollable.ensureVisible(
        GlobalObjectKey(currentPageIndex).currentContext!,
        duration:
            const Duration(milliseconds: 100), // duration for scrolling time
        alignment: .5, // 0 mean, scroll to the top, 0.5 mean, half
        curve: Curves.easeInOutCubic,
      );
    });
  }

  @override
  void didChangeDependencies() {
    _scrollController = ScrollController(
      initialScrollOffset: noOfPreviousPages * context.theme.appSize.size312.dp,
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              left: size.size18.dp,
              top: size.size26.dp,
              right: size.size18.dp,
            ),
            child: GridView.builder(
              controller: _scrollController,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisExtent: size.size88.dp,
                mainAxisSpacing: size.size24.dp,
                crossAxisSpacing: size.size24.dp,
              ),
              itemCount: widget.calendarEndYear - widget.calendarStartYear + 1,
              itemBuilder: (final BuildContext ctx, final index) => YearWidget(
                key: GlobalObjectKey(index),
                child: widget.calendarStartYear + index,
                isSelected: widget.calendarStartYear + index ==
                    widget.initialSelectedYear,
                isEnabled: widget.calendarStartYear + index >=
                        widget.minSelectedYear &&
                    widget.calendarStartYear + index <= widget.maxSelectedYear,
                onSelected: (final year) {
                  setState(() {
                    final selectedYearValue = year as int;
                    widget.onChange(selectedYearValue);
                  });
                },
               calenderColorTheme: widget.calenderColorTheme,
              ),
            ),
          ),
        ),
        Container(
          height: size.size40.dp,
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                iconSize: size.size24,
                onPressed: () {
                  if (currentPageIndex > 1) {
                    currentPageIndex = currentPageIndex - 12;
                    Scrollable.ensureVisible(
                      GlobalObjectKey(currentPageIndex).currentContext!,
                      duration: const Duration(
                        milliseconds: 200,
                      ), // duration for scrolling time
                      alignment:
                          .5, // 0 mean, scroll to the top, 0.5 mean, half
                      curve: Curves.easeInOutCubic,
                    );
                  }
                },
                icon: ImageWidget(
                  imageType: ImageType.assetImage,
                  path: 'assets/images/keyboard_arrow_left.svg',
                  color: widget.calenderColorTheme.iconColor,
                  package: 'tcs_dff_design_system',
                  fit: BoxFit.cover,
                ),
              ),
              IconButton(
                iconSize: size.size24,
                onPressed: () {
                  if (widget.calendarEndYear - widget.calendarStartYear - 12 >
                      currentPageIndex) {
                    currentPageIndex = currentPageIndex + 12;
                    Scrollable.ensureVisible(
                      GlobalObjectKey(currentPageIndex).currentContext!,
                      duration: const Duration(
                        milliseconds: 200,
                      ), // duration for scrolling time
                      alignment:
                          .5, // 0 mean, scroll to the top, 0.5 mean, half
                      curve: Curves.easeInOutCubic,
                    );
                  }
                },
                icon: ImageWidget(
                  imageType: ImageType.assetImage,
                  path: 'assets/images/keyboard_arrow_right.svg',
                  color: widget.calenderColorTheme.iconColor,
                  package: 'tcs_dff_design_system',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

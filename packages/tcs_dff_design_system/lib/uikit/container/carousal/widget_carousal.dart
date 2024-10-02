import 'dart:async';
import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import '../../../theme/theme_extensions/color_extension.dart';
import '../../../theme/theme_extensions/size_extension.dart';
import '../../../utils/sizer/app_sizer.dart';

class WidgetCarousel extends StatefulWidget {
  const WidgetCarousel({
    super.key,
    required this.widgetList,
    this.isVisiblePageIndicator = true,
    this.pageviewHeight,
    required this.imageChangeDuration,
    this.autoScroll = true,
  });

  final List<Widget> widgetList;
  final double? pageviewHeight;
  final bool isVisiblePageIndicator;
  final int imageChangeDuration;
  final bool autoScroll;

  @override
  State<WidgetCarousel> createState() => _WidgetCarouselState();
}

class _WidgetCarouselState extends State<WidgetCarousel> {
  late PageController _pageController;
  late Timer timer;
  int activePage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    scrollAction();
  }

  List<Widget> pageIndicators(
    final BuildContext context,
    final int imagesLength,
    final int currentIndex,
    final AppColorsExtension color,
    final AppSizeExtension size,
  ) =>
      List<Widget>.generate(
        imagesLength,
        (final index) => Container(
          margin: EdgeInsets.all(size.size3.dp),
          width: currentIndex == index ? size.size15.dp : size.size7.dp,
          height: size.size7.dp,
          decoration: BoxDecoration(
            color: currentIndex == index
                ? color.clrPrimaryBlue
                : color.clrPrimaryBlue90,
            borderRadius: currentIndex == index
                ? BorderRadius.all(
                    Radius.elliptical(
                      size.size10.dp,
                      size.size10.dp,
                    ),
                  )
                : BorderRadius.circular(size.size10.dp),
          ),
        ),
      );

  // ignore: lines_longer_than_80_chars
  AnimatedContainer slider(final List<Widget> images, final int pagePosition) =>
      AnimatedContainer(
        duration: Duration(milliseconds: widget.imageChangeDuration),
        curve: Curves.easeInOutCubic,
        child: images[pagePosition],
      );

  void scrollAction() {
    if (widget.autoScroll) {
      timer = Timer.periodic(Duration(seconds: widget.imageChangeDuration),
          (final timer) {
        setState(() {
          if (activePage < widget.widgetList.length - 1) {
            activePage++;
          } else {
            activePage = 0;
          }

          _pageController.animateToPage(
            activePage,
            duration: Duration(milliseconds: widget.imageChangeDuration),
            curve: Curves.easeIn,
          );
        });
      });
    }
  }

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final color = context.theme.appColor;

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: widget.pageviewHeight ?? MediaQuery.of(context).size.width,
            child: PageView.builder(
              itemCount: widget.widgetList.length,
              controller: _pageController,
              onPageChanged: (final page) {
                setState(() {
                  activePage = page;
                });
              },
              itemBuilder: (final BuildContext context, final int index) =>
                  slider(widget.widgetList, activePage),
            ),
          ),
          Visibility(
            visible: widget.isVisiblePageIndicator,
            child: Column(
              children: [
                SizedBox(
                  height: 5.dp,
                ),
                Container(
                  height: 10.dp,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: pageIndicators(
                      context,
                      widget.widgetList.length,
                      activePage,
                      color,
                      size,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    timer.cancel();
  }
}

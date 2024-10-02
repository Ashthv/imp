import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import '../../../utils/sizer/app_sizer.dart';
import 'page_tab_indicator.dart';
import 'tab_data.dart';


enum SectionTabType { backgroundPurple120, backgroundWhiteUI }

class SectionTab extends StatefulWidget {
  const SectionTab({
    super.key,
    required this.tabDataList,
    this.initialIndex = 0,
    this.sectionTabType = SectionTabType.backgroundPurple120,
    this.backgroundColor,
    this.isScrollable = true,
    this.tabAlignment = TabAlignment.start,
  });

  final List<TabData> tabDataList;
  final int initialIndex;
  final SectionTabType sectionTabType;
  final Color? backgroundColor;
  final bool isScrollable;
  final TabAlignment tabAlignment;

  @override
  State<SectionTab> createState() => _TabControllerScreenState();
}

class _TabControllerScreenState extends State<SectionTab>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late int _initialIndex;

  @override
  void initState() {
    super.initState();
    _initialIndex = widget.initialIndex;
    tabController = TabController(
      initialIndex: _initialIndex,
      length: widget.tabDataList.length,
      vsync: this,
    );
    tabController.addListener(() {
      setState(() {
        _initialIndex = tabController.index;
      });
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  TabBar _getTabBar() {
    final textStyle = context.theme.appTextStyles;
    final color = context.theme.appColor;
    final size = context.theme.appSize;

    return TabBar(
      dividerColor: color.greyWhiteUi100,
      labelColor: color.clrPrimaryPurple,
      isScrollable: widget.isScrollable,
      tabAlignment: widget.tabAlignment,
      labelStyle: widget.sectionTabType == SectionTabType.backgroundPurple120
          ? textStyle.h316pxsemiBold.copyWith(fontSize: size.size15.sp)
          : textStyle.labelSmall14Medium.copyWith(fontSize: size.size13.sp),
      indicatorColor: color.greyWhiteUi100,
      unselectedLabelColor:
          widget.sectionTabType == SectionTabType.backgroundPurple120
              ? color.greyMediumGrey40
              : color.silverDark,
      unselectedLabelStyle: widget.sectionTabType ==
              SectionTabType.backgroundPurple120
          ? textStyle.bodyCopy2Small16Regular.copyWith(fontSize: size.size15.sp)
          : textStyle.h414pxRegular.copyWith(fontSize: size.size13.sp),
      tabs: widget.tabDataList
          .map<Widget>(
            (final TabData tabData) =>
                widget.tabDataList[_initialIndex] == tabData
                    ? Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              left: size.size14.dp,
                              right: size.size14.dp,
                              top: size.size8.dp,
                              bottom: size.size10.dp,
                            ),
                            decoration: BoxDecoration(
                              color: color.greyWhiteUi100,
                              border: widget.sectionTabType ==
                                      SectionTabType.backgroundWhiteUI
                                  ? Border.all(color: color.clrPrimaryPurple110)
                                  : null,
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(size.size0, -size.size12),
                                  color: const Color(0xffE5E4E4),
                                  blurRadius: size.size12.dp,
                                ),
                              ],
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(size.size12.dp),
                                topRight: Radius.circular(size.size12.dp),
                              ),
                            ),
                            child: Text(tabData.title),
                          ),
                          Positioned(
                            left: size.size0,
                            right: size.size0,
                            bottom: size.size0,
                            child: Container(
                              decoration: PageTabIndicator(
                                color: color.clrPrimaryPurple,
                                indicatorHeight: size.size4.dp,
                                showBottomCurve: true,
                                selectedTabColor: color.greyWhiteUi100,
                                unselectedTabColor: widget.backgroundColor ??
                                    (widget.sectionTabType ==
                                            SectionTabType.backgroundPurple120
                                        ? color.clrPrimaryPurple120
                                        : color.greyWhiteUi100),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Text(tabData.title),
          )
          .toList(),
      controller: tabController,
    );
  }

  @override
  Widget build(final BuildContext context) {
    final color = context.theme.appColor;
    final size = context.theme.appSize;

    return Container(
      color: widget.backgroundColor ??
          (widget.sectionTabType == SectionTabType.backgroundPurple120
              ? color.clrPrimaryPurple120
              : color.greyWhiteUi100),
      child: Column(
        children: <Widget>[
          _getTabBar(),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: color.greyWhiteUi100,
              border: widget.sectionTabType == SectionTabType.backgroundWhiteUI
                  ? Border.all(color: color.clrPrimaryPurple110)
                  : null,
              boxShadow: [
                BoxShadow(
                  offset: Offset(size.size0, size.size12),
                  color: const Color(0xffE5E4E4),
                  blurRadius: size.size12.dp,
                ),
              ],
              borderRadius: BorderRadius.circular(size.size12.dp),
            ),
            child: widget.tabDataList[_initialIndex].body,
          ),
        ],
      ),
    );
  }
}

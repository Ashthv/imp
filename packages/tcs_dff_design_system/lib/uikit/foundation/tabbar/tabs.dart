import 'package:flutter/material.dart';

import '../../../tcs_dff_design_system.dart';
import '../../../theme/theme.dart';
import '../../../utils/sizer/app_sizer.dart';
import 'page_tab_indicator.dart';
import 'tab_data.dart';

class Tabs extends StatefulWidget {
  Tabs({
    super.key,
    required this.tabDataList,
    this.initialIndex = 0,
    this.tabType = TabType.defaultTab,
    this.isScrollable = true,
    this.tabAlignment = TabAlignment.start,
  }) {
    final checkEachTabDataHasImage = tabDataList.every(
      (final tabData) =>
          tabData.imagePackage != null && tabData.imagePath != null,
    );
    if (tabType == TabType.fullPageTab) {
      assert(
        checkEachTabDataHasImage,
        'Each tab data must have imagePackage & imagePath',
      );
    }
  }

  final List<TabData> tabDataList;
  final int initialIndex;
  final TabType tabType;
  final bool isScrollable;
  final TabAlignment tabAlignment;

  @override
  State<Tabs> createState() => _TabControllerScreenState();
}

class _TabControllerScreenState extends State<Tabs>
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
      labelColor: color.clrPrimaryPurple,
      labelStyle: widget.tabType == TabType.fullPageTab
          ? textStyle.bodyCopy1Large18Bold
          : textStyle.labelSmall14Medium,
      indicator: widget.tabType == TabType.fullPageTab
          ? PageTabIndicator(
              color: color.clrPrimaryPurple,
              indicatorHeight: size.size3.dp,
            )
          : null,
      indicatorSize: widget.tabType == TabType.fullPageTab
          ? TabBarIndicatorSize.label
          : TabBarIndicatorSize.tab,
      labelPadding: EdgeInsets.symmetric(horizontal: size.size15.dp),
      unselectedLabelColor: color.greyMediumGrey40,
      isScrollable: widget.isScrollable,
      tabAlignment: widget.tabAlignment,
      unselectedLabelStyle: widget.tabType == TabType.fullPageTab
          ? textStyle.bodyCopy1Small18Regular
          : textStyle.bodyCopy3Small14Regular,
      tabs: widget.tabDataList
          .map<Widget>(
            (final TabData tabData) => Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (tabData.imagePath != null)
                    Visibility(
                      visible: widget.tabDataList[_initialIndex] == tabData,
                      child: Row(
                        children: [
                          ImageWidget(
                            imageType: ImageType.assetImage,
                            path: tabData.imagePath ?? '',
                            package: tabData.imagePackage,
                            fit: BoxFit.fill,
                          ),
                          SizedBox(
                            width: size.size7.dp,
                          ),
                        ],
                      ),
                    ),
                  Text(tabData.title),
                  if (widget.tabType == TabType.defaultTab)
                    SizedBox(
                      width: size.size5.dp,
                    ),
                  if (widget.tabType == TabType.defaultTab)
                    Badge(
                      padding: EdgeInsets.only(
                        left: size.size8.dp,
                        right: size.size8.dp,
                      ),
                      largeSize: size.size22.dp,
                      isLabelVisible: tabData.count != null,
                      backgroundColor: color.clrPrimaryPink20,
                      label: Text('${tabData.count ?? 0}'),
                      textStyle: textStyle.labelSmall14Medium.copyWith(
                        height: 1.2,
                        color: color.greyWhiteUi100,
                      ),
                    ),
                ],
              ),
            ),
          )
          .toList(),
      controller: tabController,
    );
  }

  @override
  Widget build(final BuildContext context) => Column(
        children: <Widget>[
          _getTabBar(),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: widget.tabDataList
                  .map((final tabBarWidget) => tabBarWidget.body)
                  .toList(),
            ),
          ),
        ],
      );
}

enum TabType { fullPageTab, defaultTab }

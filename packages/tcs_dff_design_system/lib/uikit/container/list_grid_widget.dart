import 'package:flutter/material.dart';

import '../../tcs_dff_design_system.dart';
import '../../theme/theme.dart';
import '../../utils/sizer/app_sizer.dart';

class ListGridWidget extends StatefulWidget {
  final List<TitleSubtitleTextWidget> titleSubtitleTextWidgetList;
  final int columnCount;
  final double? childAspectRatio;
  final double? mainAxisSpacing;
  final double? crossAxisSpacing;
  final bool scrollEnabled;
  ListGridWidget({
    super.key,
    required this.titleSubtitleTextWidgetList,
    this.columnCount = 2,
    this.childAspectRatio,
    this.mainAxisSpacing,
    this.crossAxisSpacing,
    this.scrollEnabled = true,
  });

  @override
  State<ListGridWidget> createState() => _ListGridWidgetState();
}

class _ListGridWidgetState extends State<ListGridWidget> {
  @override
  Widget build(final BuildContext context) => GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing:
              widget.crossAxisSpacing ?? context.theme.appSize.size16.dp,
          mainAxisSpacing:
              widget.mainAxisSpacing ?? context.theme.appSize.size16.dp,
          childAspectRatio: widget.childAspectRatio != null
              ? widget.childAspectRatio!
              : widget.columnCount == 2
                  ? (2.8 / 1)
                  : (11 / 1),
          crossAxisCount: widget.columnCount,
        ),
        shrinkWrap: true,
        physics: widget.scrollEnabled
            ? const AlwaysScrollableScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        children: widget.titleSubtitleTextWidgetList,
      );
}

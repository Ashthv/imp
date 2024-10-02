import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../../utils/sizer/app_sizer.dart';

class Accordian extends StatefulWidget {
  final String title;
  final Widget? content;
  final String? subtitle;
  final Widget? iconData;
  final ValueChanged<bool>? onExpanded;
  final bool isDisabled;

  const Accordian({
    super.key,
    required this.title,
    this.subtitle,
    this.onExpanded,
    this.content,
    this.iconData,
    required this.isDisabled,
  });

  @override
  State<Accordian> createState() => _AccordionState();
}

class _AccordionState extends State<Accordian> {
  var _showContent = false;

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final color = context.theme.appColor;
    final textStyle = context.theme.appTextStyles;

    return IgnorePointer(
      ignoring: widget.isDisabled,
      child: Column(
        children: [
          ExpansionTile(
            collapsedIconColor: widget.isDisabled
                ? color.greyLightestGrey80
                : color.clrPrimaryBlue,
            collapsedShape: Border(
              bottom: BorderSide(
                color: widget.isDisabled
                    ? color.greyLightestGrey80
                    : color.greyLighterGrey70,
                width: size.size3.dp,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(size.size6.dp)),
            ),
            childrenPadding: EdgeInsets.only(
              bottom: size.size20.dp,
              right: size.size12.dp,
              left: size.size12.dp,
            ),
            tilePadding: EdgeInsets.symmetric(horizontal: size.size12.dp),
            title: Text(
              widget.title,
              style: _showContent
                  ? textStyle.bodyCopy2Small16Regular.copyWith(
                      fontWeight: FontWeight.w500,
                      color: color.clrPrimaryPurple,
                    )
                  : textStyle.bodyCopy2Small16Regular.copyWith(
                      color: widget.isDisabled
                          ? color.greyLightestGrey80
                          : color.greyBlackUi10,
                    ),
            ),
            backgroundColor: color.clrPrimaryPurple120,
            collapsedBackgroundColor: color.greyFullWhite120,
            onExpansionChanged: (final value) {
              setState(() {
                _showContent = value;
                if (widget.onExpanded != null) {
                  widget.onExpanded!(_showContent);
                }
              });
            },
            subtitle: _showContent
                ? (widget.subtitle != null ? Text(widget.subtitle!) : null)
                : null,
            // leading: widget.iconData,
            children: widget.content != null
                ? [
                    widget.content!,
                  ]
                : [],
          ),
          Visibility(
            visible: !_showContent,
            child: Divider(
              height: size.size0.dp,
              thickness: size.size2.dp,
            ),
          ),
        ],
      ),
    );
  }
}

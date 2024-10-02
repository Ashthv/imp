import 'package:flutter/material.dart';

import '../../../tcs_dff_design_system.dart';
import '../../../theme/theme.dart';
import '../../../utils/sizer/app_sizer.dart';

class IconCotentCard extends StatefulWidget {
  final String iconPath;
  final String title;
  final String? subTitle;
  final String package;
  final bool isSelected;
  final Function(bool) onSelect;
  final Color? titleTextColor;
  final bool isShowArrow;

  IconCotentCard({
    super.key,
    required this.iconPath,
    required this.title,
    this.subTitle,
    required this.package,
    required this.isSelected,
    required this.onSelect,
    this.titleTextColor,
    required this.isShowArrow,
  });

  @override
  State<IconCotentCard> createState() => _IconCotentCard();
}

class _IconCotentCard extends State<IconCotentCard> {
  late bool _isSelected;

  @override
  void initState() {
    super.initState();
    _isSelected = widget.isSelected;
  }

  @override
  void didUpdateWidget(covariant final IconCotentCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    _isSelected = oldWidget.isSelected;
  }

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final color = context.theme.appColor;
    final textStyle = context.theme.appTextStyles;

    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
          widget.onSelect.call(_isSelected);
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            color: _isSelected ? color.clrPrimaryPurple : color.greyWhiteUi100,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: color.greyLightestGrey80),
              borderRadius: BorderRadius.circular(size.size12.dp),
            ),
            child: Padding(
              padding: EdgeInsets.all(size.size12.dp),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ImageWidget(
                        imageType: ImageType.assetImage,
                        path: widget.iconPath,
                        color: _isSelected
                            ? color.greyOffWhite90
                            : color.clrPrimaryPurple,
                        package: widget.package,
                      ),
                      if (widget.isShowArrow == true)
                        ImageWidget(
                          imageType: ImageType.assetImage,
                          path: 'assets/images/keyboard_arrow_right.svg',
                          color: _isSelected
                              ? color.greyOffWhite90
                              : color.clrPrimaryPurple,
                          package: 'tcs_dff_design_system',
                        )
                      else
                        const SizedBox.shrink(),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: size.size8.dp),
                    child: Text(
                      widget.title,
                      style: textStyle.h316pxsemiBold.copyWith(
                        color: _isSelected
                            ? color.greyWhiteUi100
                            : (widget.titleTextColor != null)
                                ? widget.titleTextColor
                                : color.clrPrimaryPurple,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (widget.subTitle != null)
                    Padding(
                      padding: EdgeInsets.only(top: size.size4.dp),
                      child: Text(
                        widget.subTitle ?? '',
                        style: textStyle.bodyCopy3Small14Regular.copyWith(
                          color: _isSelected
                              ? color.greyOffWhite90
                              : color.greyDarkGrey30,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  else
                    const SizedBox.shrink(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

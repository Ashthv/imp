import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../theme/theme.dart';
import '../../utils/bottom_nav_bar_utils.dart';
import '../../utils/sizer/app_sizer.dart';
import '../foundation/icon_widget.dart';
import '../foundation/text_widget.dart';

class BottomNavBar extends StatefulWidget {
  BottomNavBar({
    super.key,
    required this.bottomNavigationIcons,
    this.centerButtonData,
    this.isCenterButtonPressed = false,
    this.backgroundColor = AppColors.greyWhiteUi100,
    this.bottomBarAlignment = BottomBarAlignment.vertical,
    required this.onIconClicked,
    this.package,
  });

  final List<NavBarIconData> bottomNavigationIcons;
  final String? centerButtonData;
  final Color backgroundColor;
  final bool isCenterButtonPressed;
  final Function() onIconClicked;
  final BottomBarAlignment bottomBarAlignment;
  final String? package;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  List<bool> handleIconsCallback = [];

  @override
  void initState() {
    resetIconTabStatus();
    super.initState();
  }

  Widget iconWithLabel({
    required final BuildContext context,
    required final NavBarIconData iconData,
    final bool isPressed = false,
    required final VoidCallback callback,
    final String? package,
  }) {
    final _color = context.theme.appColor;
    final _size = context.theme.appSize;
    return Container(
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: InkWell(
        onTap: callback,
        overlayColor: MaterialStatePropertyAll(_color.transparent),
        child: widget.bottomBarAlignment == BottomBarAlignment.vertical
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconWidget(
                    iconName: iconData.iconPath,
                    iconSize: IconSize.small,
                    iconColor: !isPressed
                        ? _color.greyMediumGrey40
                        : _color.clrPrimaryPurple,
                    package: package,
                  ),
                  Text(
                    iconData.iconLabel,
                    style: context.theme.appTextStyles.detailsSmall12Regular
                        .copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: _size.size12.dp,
                      color: !isPressed
                          ? _color.greyMediumGrey40
                          : _color.clrPrimaryPurple,
                    ),
                  ),
                ],
              )
            : Row(
                children: [
                  IconWidget(
                    iconName: iconData.iconPath,
                    iconSize: IconSize.small,
                    iconColor: !isPressed
                        ? _color.greyMediumGrey40
                        : _color.clrPrimaryPurple,
                    package: package,
                  ),
                  Text(
                    iconData.iconLabel,
                    style: context.theme.appTextStyles.detailsSmall12Regular
                        .copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: _size.size12.dp,
                      color: !isPressed
                          ? _color.greyMediumGrey40
                          : _color.clrPrimaryPurple,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final style = context.theme.appTextStyles;
    final color = context.theme.appColor;

    if (widget.isCenterButtonPressed) {
      resetIconTabStatus();
    }

    return BottomAppBar(
      color: widget.backgroundColor,
      shape: const CircularNotchedRectangle(),
      notchMargin: size.size5.dp,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: widget.bottomBarAlignment == BottomBarAlignment.vertical
                  ? EdgeInsets.only(top: size.size0.dp)
                  : EdgeInsets.only(top: size.size16.dp),
              child: Row(
                mainAxisAlignment: widget.centerButtonData != null
                    ? MainAxisAlignment.spaceEvenly
                    : MainAxisAlignment.spaceAround,
                children: getIconLabels(
                  context,
                  0,
                  widget.bottomNavigationIcons.length ~/ 2,
                ),
              ),
            ),
          ),
          Visibility(
            visible: widget.centerButtonData != null,
            child: Padding(
              padding: widget.bottomBarAlignment == BottomBarAlignment.vertical
                  ? EdgeInsets.only(top: size.size22.dp)
                  : EdgeInsets.only(top: size.size16.dp),
              child: TextWidget(
                text: widget.centerButtonData ?? '',
                style: style.detailsSmall12Regular.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: size.size12.dp,
                  color: !widget.isCenterButtonPressed
                      ? color.greyMediumGrey40
                      : color.clrPrimaryPurple,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: widget.bottomBarAlignment == BottomBarAlignment.vertical
                  ? EdgeInsets.only(top: size.size0.dp)
                  : EdgeInsets.only(top: size.size16.dp),
              child: Row(
                mainAxisAlignment: widget.centerButtonData != null
                    ? MainAxisAlignment.spaceEvenly
                    : MainAxisAlignment.spaceAround,
                children: getIconLabels(
                  context,
                  widget.bottomNavigationIcons.length ~/ 2,
                  widget.bottomNavigationIcons.length,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> getIconLabels(
    final BuildContext context,
    final int startIndex,
    final int endIndex,
  ) {
    final iconLabels = <Widget>[];
    for (var i = startIndex; i < endIndex; i++) {
      iconLabels.add(
        iconWithLabel(
          context: context,
          iconData: widget.bottomNavigationIcons[i],
          package: widget.package,
          callback: () {
            if (handleIconsCallback.contains(true)) {
              resetIconTabStatus();
            }
            widget.onIconClicked();
            handleIconsCallback[i] = true;
            setState(() {});
          },
          isPressed: handleIconsCallback[i],
        ),
      );
    }
    return iconLabels;
  }

  void resetIconTabStatus() {
    handleIconsCallback =
        List.filled(widget.bottomNavigationIcons.length, false);
  }

  @override
  void dispose() {
    resetIconTabStatus();
    super.dispose();
  }
}

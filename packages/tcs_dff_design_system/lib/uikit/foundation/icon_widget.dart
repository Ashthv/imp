import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../theme/theme.dart';
import '../../utils/sizer/app_sizer.dart';

class IconWidget extends StatelessWidget {
  final String iconName;
  final Color? iconColor;
  final IconSize iconSize;
  final void Function()? onPressed;
  final String? package;
  final BoxFit fit;

  const IconWidget({
    super.key,
    required this.iconName,
    this.iconColor,
    required this.iconSize,
    this.onPressed,
    this.package,
    this.fit = BoxFit.none,
  });

  @override
  Widget build(final BuildContext context) => InkWell(
        onTap: onPressed,
        splashColor: context.theme.appColor.transparent,
        highlightColor: context.theme.appColor.transparent,
        child: _checkIfImageTypeSvg()
            ? buildImageWidget(iconName, context)
            : ImageIcon(
                AssetImage(iconName, package: package),
                size: getIconSize(iconSize, context),
                color: iconColor,
              ),
      );

  double getIconSize(final IconSize iconType, final BuildContext context) {
    switch (iconType) {
      case IconSize.small:
        return context.theme.appSize.size24.dp;
      case IconSize.large:
        return context.theme.appSize.size40.dp;
    }
  }

  SvgPicture buildImageWidget(final String path, final BuildContext context) =>
      iconColor != null
          ? SvgPicture.asset(
              package: package,
              path,
              fit: fit,
              height: getIconSize(iconSize, context),
              width: getIconSize(iconSize, context),
              colorFilter: ColorFilter.mode(iconColor!, BlendMode.srcIn),
            )
          : SvgPicture.asset(
              package: package,
              path,
              fit: fit,
              height: getIconSize(iconSize, context),
              width: getIconSize(iconSize, context),
            );

  bool _checkIfImageTypeSvg() => iconName.split('.')[1] == 'svg';
}

enum IconSize { small, large }

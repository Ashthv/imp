import 'package:flutter/material.dart';

import '../../../tcs_dff_design_system.dart';
import '../../../theme/size.dart';
import '../../../theme/theme.dart';
import '../../../utils/sizer/app_sizer.dart';

class ProgressAppBar extends DefaultAppBar {
  final String currentRoutePath;
  final List<ProgressIndicatorConfig> progressIndicatorConfigs;
  @override
  final double? appBarHeight;

  const ProgressAppBar({
    super.key,
    required super.title,
    super.subTitle,
    super.actions = const [],
    super.showBackButton = true,
    super.backgroundColor,
    super.backButtonColor,
    super.titleTextStyle,
    super.subTitleTextStyle,
    super.onBackButtonTap,
    required this.currentRoutePath,
    required this.progressIndicatorConfigs,
    this.appBarHeight,
  });

  @override
  Widget build(final BuildContext context) => Column(
        children: [
          super.build(context),
          ColoredBox(
            color: backgroundColor ?? context.theme.appColor.greyWhiteUi100,
            child: ProgressBar(
              currentRoutePath: currentRoutePath,
              progressIndicatorConfigs: progressIndicatorConfigs,
            ),
          ),
        ],
      );

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight ?? AppSizes.size75.sp);
}

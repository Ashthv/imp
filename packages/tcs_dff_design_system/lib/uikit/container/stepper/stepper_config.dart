import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class StepperConfig {
  final String iconPath;
  final String imagePackage;
  final String title;
  final String? subTitle;
  final ProgressStatus status;

  StepperConfig({
    required this.imagePackage,
    required this.iconPath,
    required this.title,
    this.subTitle,
    required this.status,
  });
}

enum ProgressStatus {
  inProgress,
  pending,
  completed;

  TextStyle getTitleStyles(final BuildContext context) {
    final color = context.theme.appColor;
    final textStyle = context.theme.appTextStyles;
    switch (this) {
      case ProgressStatus.pending:
        return textStyle.h218pxbold.copyWith(color: color.greyDarkGrey30);

      default:
        return textStyle.bodyCopy1Large18Bold
            .copyWith(color: color.clrPrimaryBlue);
    }
  }

  TextStyle getSubTitleStyles(final BuildContext context) {
    final color = context.theme.appColor;
    final textStyle = context.theme.appTextStyles;
    switch (this) {
      case ProgressStatus.pending:
        return textStyle.h414pxRegular.copyWith(color: color.greyLightGrey60);

      default:
        return textStyle.h414pxRegular.copyWith(color: color.clrPrimaryBlue50);
    }
  }

  Color getIconBgColor(final BuildContext context) {
    final color = context.theme.appColor;
    switch (this) {
      case ProgressStatus.inProgress:
        return color.clrPrimaryBlue;

      case ProgressStatus.completed:
        return color.statLightGreen;

      default:
        return color.transparent;
    }
  }

  Color? getIconColor(final BuildContext context) {
    final color = context.theme.appColor;
    switch (this) {
      case ProgressStatus.pending:
        return color.clrPrimaryBlue;

      case ProgressStatus.inProgress:
        return color.greyFullWhite120;

      default:
        return null;
    }
  }

  Color getProgressLineColor(final BuildContext context) {
    final color = context.theme.appColor;
    switch (this) {
      case ProgressStatus.completed:
        return color.statGreenDefault;

      default:
        return color.clrPrimaryBlue80;
    }
  }
}

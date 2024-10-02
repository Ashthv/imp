import 'package:flutter/material.dart';
import '../theme/size.dart';
import 'sizer/app_sizer.dart';

enum ButtonVariants {
  normal,

  cardTwoColumn,

  cardFourColumn,

  fourColumn,

  twoColumn,

  circular;

  Size size() {
    switch (this) {
      case ButtonVariants.normal:
        return Size(AppSizes.size108.sp, AppSizes.size48.sp);
      case ButtonVariants.cardTwoColumn:
        return Size(AppSizes.size144.sp, AppSizes.size40.sp);
      case ButtonVariants.cardFourColumn:
        return Size(AppSizes.size308.sp, AppSizes.size40.sp);
      case ButtonVariants.fourColumn:
        return Size(AppSizes.size348.sp, AppSizes.size48.sp);
      case ButtonVariants.twoColumn:
        return Size(AppSizes.size166.sp, AppSizes.size48.sp);
      case ButtonVariants.circular:
        return Size(AppSizes.size56.sp, AppSizes.size56.sp);
    }
  }
}

enum TwoColumnButtonVariants {
  borderlined,
  normal,
}

enum RoundedButtonType {
  filled,
  borderlined,
}

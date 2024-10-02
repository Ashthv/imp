import 'package:flutter/material.dart';

class AppDimensionExtension extends ThemeExtension<AppDimensionExtension> {
  // Card
  double get leadingWidth => 80;
  double get appbarHeight => 100;
  double get borderRadius => 18;
  double get cardHeight => 200;
  double get cardWidth => 200;
  double get margin5 => 5;
  double get margin10 => 10;
  double get margin20 => 20;
  double get margin8 => 8;
  double get cardElevation => 5;
  double get boarderWidth => 2;

  // Accordian
  double get accordianPadding => 20;
  double get accordianTopPadding => 30;
  double get accordianDividerHeight => 2;
  double get accordianBorderRadius => 12;

  // Icons
  double get smallIconSize => 24.0;
  double get largeIconSize => 40.0;

  // TimeSlot
  double get wrapSpacing => 20.0;
  double get edgeDimens => 10.0;
  double get gridCount => 3;
  double get aspectRatio => 2.0;

  // Image Container
  double get imageContainerDividerPadding => 7;
  double get imageContainerDividerThickness => 1;
  double get imageContainerBorderRadius => 25;
  double get imageContainerMargin => 10;
  double get imageContainerPadding => 18;
  double get circularAvatarRadius => 25;
  double get height15 => 15;

  // Image Carousel
  double get imageHeightOffset => 500;
  double get indicatorMargin => 3;
  double get selectedPageIndicatorWidth => 15;
  double get indicatorDimension => 7;
  double get indicatorBorderRadius => 10;
  double get activePageOffset => 0;

  // Tab Switch
  double get componentLeftPadding => 22;
  double get componentRightPadding => 22;
  double get componentTopPadding => 30;
  double get tabBarHeight => 50;
  double get tabBarHorizontalPadding => 5;
  double get tabBarVerticalPadding => 5;

  // Title Subtitle
  double get titleSubtitleGap => 5;

  // 7:3 radio and popup
  double get radioWidth => 24;
  double get radioHeight => 24;
  double get radioSecondWidth => 21;
  double get radioSecondHeight => 21;
  double get radioThirdWidth => 14;
  double get radioThirdHeight => 14;
  double get otpFiledWidth => 50;
  double get thirtyDp => 30;
  double get twentyDp => 20;
  double get fourDp => 4;
  double get zeroDp => 4;

  @override
  ThemeExtension<AppDimensionExtension> copyWith() => AppDimensionExtension();

  @override
  ThemeExtension<AppDimensionExtension> lerp(
    covariant final ThemeExtension<AppDimensionExtension>? other,
    final double t,
  ) =>
      AppDimensionExtension();
}

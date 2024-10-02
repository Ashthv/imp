import 'package:flutter/material.dart';

class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  // Key Colors Primary
  final Color clrPrimaryPurple;
  final Color clrPrimaryPink;
  final Color clrPrimaryBlue;

  // Primary/Purple/Opacity
  final Color clrPrimaryPurple10;
  final Color clrPrimaryPurple20;
  final Color clrPrimaryPurple30;
  final Color clrPrimaryPurple40;
  final Color clrPrimaryPurple50;
  final Color clrPrimaryPurple60;
  final Color clrPrimaryPurple70;
  final Color clrPrimaryPurple80;
  final Color clrPrimaryPurple90;
  final Color clrPrimaryPurple100;
  final Color clrPrimaryPurple110;
  final Color clrPrimaryPurple120;
  final Color clrPrimaryPurpleHover;

  // Primary/Pink/Opacity
  final Color clrPrimaryPink10;
  final Color clrPrimaryPink20;
  final Color clrPrimaryPink30;
  final Color clrPrimaryPink40;
  final Color clrPrimaryPink50;
  final Color clrPrimaryPink60;
  final Color clrPrimaryPink70;
  final Color clrPrimaryPink80;
  final Color clrPrimaryPink90;
  final Color clrPrimaryPink100;
  final Color clrPrimaryPink110;

  // Primary/Blue/Opacity
  final Color clrPrimaryBlue10;
  final Color clrPrimaryBlue20;
  final Color clrPrimaryBlue30;
  final Color clrPrimaryBlue40;
  final Color clrPrimaryBlue50;
  final Color clrPrimaryBlue60;
  final Color clrPrimaryBlue70;
  final Color clrPrimaryBlue80;
  final Color clrPrimaryBlue90;
  final Color clrPrimaryBlue100;
  final Color clrPrimaryBlue110;

  // Grey/Shades
  final Color greyFullBlack10;
  final Color greyFullWhite120;
  final Color greyBlackUi10;
  final Color greyDarkestGrey20;
  final Color greyDarkGrey30;
  final Color greyMediumGrey40;
  final Color greyGrey50;
  final Color greyLightGrey60;
  final Color greyLighterGrey70;
  final Color greyLightestGrey80;
  final Color greyOffWhite90;
  final Color greyWhiteUi100;
  final Color greyShades100;
  final Color greyShades300;
  final Color greyShades400;
  final Color greyShades900;
  final Color greyGrey5;
  final Color greyGrey7;

  // Status
  final Color statAmberDark;
  final Color statRedDark;
  final Color greenDark;
  final Color statAmber; // color not matching with color code
  final Color statRedDefault;
  final Color statGreenDefault;
  final Color statLightAmber;
  final Color statRedLightRed;
  final Color statLightGreen;

  //Rewards
  final Color goldLighter;
  final Color goldMedium;
  final Color goldDark;
  final Color silverLighter;
  final Color silverMedium;
  final Color silverDark;
  final Color bronzeLighter;
  final Color bronzeMedium;
  final Color bronzeDark;
  final Color platinumLighter;
  final Color platinumMedium;
  final Color platinumDark;
  final Color transparent;

  AppColorsExtension({
    required this.clrPrimaryPurple,
    required this.clrPrimaryPink,
    required this.clrPrimaryBlue,
    required this.clrPrimaryPurple10,
    required this.clrPrimaryPurple20,
    required this.clrPrimaryPurple30,
    required this.clrPrimaryPurple40,
    required this.clrPrimaryPurple50,
    required this.clrPrimaryPurple60,
    required this.clrPrimaryPurple70,
    required this.clrPrimaryPurple80,
    required this.clrPrimaryPurple90,
    required this.clrPrimaryPurple100,
    required this.clrPrimaryPurple110,
    required this.clrPrimaryPurple120,
    required this.clrPrimaryPurpleHover,
    required this.clrPrimaryPink10,
    required this.clrPrimaryPink20,
    required this.clrPrimaryPink30,
    required this.clrPrimaryPink40,
    required this.clrPrimaryPink50,
    required this.clrPrimaryPink60,
    required this.clrPrimaryPink70,
    required this.clrPrimaryPink80,
    required this.clrPrimaryPink90,
    required this.clrPrimaryPink100,
    required this.clrPrimaryPink110,
    required this.clrPrimaryBlue10,
    required this.clrPrimaryBlue20,
    required this.clrPrimaryBlue30,
    required this.clrPrimaryBlue40,
    required this.clrPrimaryBlue50,
    required this.clrPrimaryBlue60,
    required this.clrPrimaryBlue70,
    required this.clrPrimaryBlue80,
    required this.clrPrimaryBlue90,
    required this.clrPrimaryBlue100,
    required this.clrPrimaryBlue110,
    required this.greyFullBlack10,
    required this.greyFullWhite120,
    required this.greyBlackUi10,
    required this.greyDarkestGrey20,
    required this.greyDarkGrey30,
    required this.greyMediumGrey40,
    required this.greyGrey50,
    required this.greyLightGrey60,
    required this.greyLighterGrey70,
    required this.greyLightestGrey80,
    required this.greyOffWhite90,
    required this.greyWhiteUi100,
    required this.greyShades100,
    required this.greyShades300,
    required this.greyShades400,
    required this.greyShades900,
    required this.greyGrey5,
    required this.greyGrey7,
    required this.statAmberDark,
    required this.statRedDark,
    required this.greenDark,
    required this.statAmber,
    required this.statRedDefault,
    required this.statGreenDefault,
    required this.statLightAmber,
    required this.statRedLightRed,
    required this.statLightGreen,
    required this.goldLighter,
    required this.goldMedium,
    required this.goldDark,
    required this.silverLighter,
    required this.silverMedium,
    required this.silverDark,
    required this.bronzeLighter,
    required this.bronzeMedium,
    required this.bronzeDark,
    required this.platinumLighter,
    required this.platinumMedium,
    required this.platinumDark,
    required this.transparent,
  });

  @override
  ThemeExtension<AppColorsExtension> lerp(
    covariant final ThemeExtension<AppColorsExtension>? other,
    final double t,
  ) {
    throw UnimplementedError();
  }

  @override
  ThemeExtension<AppColorsExtension> copyWith({
    final Color? clrPrimaryPurple,
    final Color? clrPrimaryPink,
    final Color? clrPrimaryBlue,
    final Color? clrPrimaryPurple10,
    final Color? clrPrimaryPurple20,
    final Color? clrPrimaryPurple30,
    final Color? clrPrimaryPurple40,
    final Color? clrPrimaryPurple50,
    final Color? clrPrimaryPurple60,
    final Color? clrPrimaryPurple70,
    final Color? clrPrimaryPurple80,
    final Color? clrPrimaryPurple90,
    final Color? clrPrimaryPurple100,
    final Color? clrPrimaryPurple110,
    final Color? clrPrimaryPurple120,
    final Color? clrPrimaryPurpleHover,
    final Color? clrPrimaryPink10,
    final Color? clrPrimaryPink20,
    final Color? clrPrimaryPink30,
    final Color? clrPrimaryPink40,
    final Color? clrPrimaryPink50,
    final Color? clrPrimaryPink60,
    final Color? clrPrimaryPink70,
    final Color? clrPrimaryPink80,
    final Color? clrPrimaryPink90,
    final Color? clrPrimaryPink100,
    final Color? clrPrimaryPink110,
    final Color? clrPrimaryBlue10,
    final Color? clrPrimaryBlue20,
    final Color? clrPrimaryBlue30,
    final Color? clrPrimaryBlue40,
    final Color? clrPrimaryBlue50,
    final Color? clrPrimaryBlue60,
    final Color? clrPrimaryBlue70,
    final Color? clrPrimaryBlue80,
    final Color? clrPrimaryBlue90,
    final Color? clrPrimaryBlue100,
    final Color? clrPrimaryBlue110,
    final Color? greyFullBlack10,
    final Color? greyFullWhite120,
    final Color? greyBlackUi10,
    final Color? greyDarkestGrey20,
    final Color? greyDarkGrey30,
    final Color? greyMediumGrey40,
    final Color? greyGrey50,
    final Color? greyLightGrey60,
    final Color? greyLighterGrey70,
    final Color? greyLightestGrey80,
    final Color? greyOffWhite90,
    final Color? greyWhiteUi100,
    final Color? greyShades100,
    final Color? greyShades300,
    final Color? greyShades400,
    final Color? greyShades900,
    final Color? greyGrey5,
    final Color? greyGrey7,
    final Color? statAmberDark,
    final Color? statRedDark,
    final Color? greenDark,
    final Color? statAmber,
    final Color? statRedDefault,
    final Color? statGreenDefault,
    final Color? statLightAmber,
    final Color? statRedLightRed,
    final Color? statLightGreen,
    final Color? goldLighter,
    final Color? goldMedium,
    final Color? goldDark,
    final Color? silverLighter,
    final Color? silverMedium,
    final Color? silverDark,
    final Color? bronzeLighter,
    final Color? bronzeMedium,
    final Color? bronzeDark,
    final Color? platinumLighter,
    final Color? platinumMedium,
    final Color? platinumDark,
    final Color? transparent,
  }) =>
      AppColorsExtension(
        clrPrimaryPurple: clrPrimaryPurple ?? this.clrPrimaryPurple,
        clrPrimaryPink: clrPrimaryPink ?? this.clrPrimaryPink,
        clrPrimaryBlue: clrPrimaryBlue ?? this.clrPrimaryBlue,
        clrPrimaryPurple10: clrPrimaryPurple10 ?? this.clrPrimaryPurple10,
        clrPrimaryPurple20: clrPrimaryPurple20 ?? this.clrPrimaryPurple20,
        clrPrimaryPurple30: clrPrimaryPurple30 ?? this.clrPrimaryPurple30,
        clrPrimaryPurple40: clrPrimaryPurple40 ?? this.clrPrimaryPurple40,
        clrPrimaryPurple50: clrPrimaryPurple50 ?? this.clrPrimaryPurple50,
        clrPrimaryPurple60: clrPrimaryPurple60 ?? this.clrPrimaryPurple60,
        clrPrimaryPurple70: clrPrimaryPurple70 ?? this.clrPrimaryPurple70,
        clrPrimaryPurple80: clrPrimaryPurple80 ?? this.clrPrimaryPurple80,
        clrPrimaryPurple90: clrPrimaryPurple90 ?? this.clrPrimaryPurple90,
        clrPrimaryPurple100: clrPrimaryPurple100 ?? this.clrPrimaryPurple100,
        clrPrimaryPurple110: clrPrimaryPurple110 ?? this.clrPrimaryPurple110,
        clrPrimaryPurple120: clrPrimaryPurple120 ?? this.clrPrimaryPurple120,
        clrPrimaryPurpleHover:
            clrPrimaryPurpleHover ?? this.clrPrimaryPurpleHover,
        clrPrimaryPink10: clrPrimaryPink10 ?? this.clrPrimaryPink10,
        clrPrimaryPink20: clrPrimaryPink20 ?? this.clrPrimaryPink20,
        clrPrimaryPink30: clrPrimaryPink30 ?? this.clrPrimaryPink30,
        clrPrimaryPink40: clrPrimaryPink40 ?? this.clrPrimaryPink40,
        clrPrimaryPink50: clrPrimaryPink50 ?? this.clrPrimaryPink50,
        clrPrimaryPink60: clrPrimaryPink60 ?? this.clrPrimaryPink60,
        clrPrimaryPink70: clrPrimaryPink70 ?? this.clrPrimaryPink70,
        clrPrimaryPink80: clrPrimaryPink80 ?? this.clrPrimaryPink80,
        clrPrimaryPink90: clrPrimaryPink90 ?? this.clrPrimaryPink90,
        clrPrimaryPink100: clrPrimaryPink100 ?? this.clrPrimaryPink100,
        clrPrimaryPink110: clrPrimaryPink110 ?? this.clrPrimaryPink110,
        clrPrimaryBlue10: clrPrimaryBlue10 ?? this.clrPrimaryBlue10,
        clrPrimaryBlue20: clrPrimaryBlue20 ?? this.clrPrimaryBlue20,
        clrPrimaryBlue30: clrPrimaryBlue30 ?? this.clrPrimaryBlue30,
        clrPrimaryBlue40: clrPrimaryBlue40 ?? this.clrPrimaryBlue40,
        clrPrimaryBlue50: clrPrimaryBlue50 ?? this.clrPrimaryBlue50,
        clrPrimaryBlue60: clrPrimaryBlue60 ?? this.clrPrimaryBlue60,
        clrPrimaryBlue70: clrPrimaryBlue70 ?? this.clrPrimaryBlue70,
        clrPrimaryBlue80: clrPrimaryBlue80 ?? this.clrPrimaryBlue80,
        clrPrimaryBlue90: clrPrimaryBlue90 ?? this.clrPrimaryBlue90,
        clrPrimaryBlue100: clrPrimaryBlue100 ?? this.clrPrimaryBlue100,
        clrPrimaryBlue110: clrPrimaryBlue110 ?? this.clrPrimaryBlue110,
        greyFullBlack10: greyFullBlack10 ?? this.greyFullBlack10,
        greyFullWhite120: greyFullWhite120 ?? this.greyFullWhite120,
        greyBlackUi10: greyBlackUi10 ?? this.greyBlackUi10,
        greyDarkestGrey20: greyDarkestGrey20 ?? this.greyDarkestGrey20,
        greyDarkGrey30: greyDarkGrey30 ?? this.greyDarkGrey30,
        greyMediumGrey40: greyMediumGrey40 ?? this.greyMediumGrey40,
        greyGrey50: greyGrey50 ?? this.greyGrey50,
        greyLightGrey60: greyLightGrey60 ?? this.greyLightGrey60,
        greyLighterGrey70: greyLighterGrey70 ?? this.greyLighterGrey70,
        greyLightestGrey80: greyLightestGrey80 ?? this.greyLightestGrey80,
        greyOffWhite90: greyOffWhite90 ?? this.greyOffWhite90,
        greyWhiteUi100: greyWhiteUi100 ?? this.greyWhiteUi100,
        greyShades100: greyShades100 ?? this.greyShades100,
        greyShades300: greyShades100 ?? this.greyShades300,
        greyShades400: greyShades400 ?? this.greyShades400,
        greyShades900: greyShades100 ?? this.greyShades900,
        greyGrey5: greyGrey5 ?? this.greyGrey5,
        greyGrey7: greyGrey7 ?? this.greyGrey7,
        statAmberDark: statAmberDark ?? this.statAmberDark,
        statRedDark: statRedDark ?? this.statRedDark,
        greenDark: greenDark ?? this.greenDark,
        statAmber: statAmber ?? this.statAmber,
        statRedDefault: statRedDefault ?? this.statRedDefault,
        statGreenDefault: statGreenDefault ?? this.statGreenDefault,
        statLightAmber: statLightAmber ?? this.statLightAmber,
        statRedLightRed: statRedLightRed ?? this.statRedLightRed,
        statLightGreen: statLightGreen ?? this.statLightGreen,
        goldLighter: goldLighter ?? this.goldLighter,
        goldMedium: goldMedium ?? this.goldMedium,
        goldDark: goldDark ?? this.goldDark,
        silverLighter: silverLighter ?? this.silverLighter,
        silverMedium: silverMedium ?? this.silverMedium,
        silverDark: silverDark ?? this.silverDark,
        bronzeLighter: bronzeLighter ?? this.bronzeLighter,
        bronzeMedium: bronzeMedium ?? this.bronzeMedium,
        bronzeDark: bronzeDark ?? this.bronzeDark,
        platinumLighter: platinumLighter ?? this.platinumLighter,
        platinumMedium: platinumMedium ?? this.platinumMedium,
        platinumDark: platinumDark ?? this.platinumDark,
        transparent: transparent ?? this.transparent,
      );
}

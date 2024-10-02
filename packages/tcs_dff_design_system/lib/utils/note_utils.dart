import 'package:flutter/material.dart';
import '../theme/theme.dart';
import 'sizer/app_sizer.dart';

enum NoteVariants {
  floatingNote,
  richNote,
  note,
  errorNote,
  plainText,
  infoNote,
  errorInfoNote,
  warningInfoNote;

  EdgeInsets getPadding(final BuildContext context) {
    final size = context.theme.appSize;
    switch (this) {
      case NoteVariants.floatingNote:
        return EdgeInsets.symmetric(
          vertical: size.size14.dp,
          horizontal: size.size16.dp,
        );

      case NoteVariants.infoNote:
        return EdgeInsets.all(size.size12.dp);

      case NoteVariants.richNote:
        return EdgeInsets.symmetric(
          vertical: size.size16.dp,
          horizontal: size.size20.dp,
        );
      case NoteVariants.note:
        return EdgeInsets.symmetric(
          vertical: size.size16.dp,
          horizontal: size.size20.dp,
        );
      case NoteVariants.errorNote:
        return EdgeInsets.symmetric(
          vertical: size.size16.dp,
          horizontal: size.size20.dp,
        );
      case NoteVariants.plainText:
        return EdgeInsets.symmetric(
          vertical: size.size16.dp,
          horizontal: size.size20.dp,
        );
      case NoteVariants.errorInfoNote:
        return EdgeInsets.symmetric(
          vertical: size.size8.dp,
          horizontal: size.size16.dp,
        );
      case NoteVariants.warningInfoNote:
        return EdgeInsets.symmetric(
          vertical: size.size8.dp,
          horizontal: size.size16.dp,
        );
      default:
        return EdgeInsets.symmetric(
          vertical: size.size16.dp,
          horizontal: size.size20.dp,
        );
    }
  }

  Color getBgColor(final BuildContext context) {
    final appColor = context.theme.appColor;
    switch (this) {
      case NoteVariants.richNote:
        return appColor.clrPrimaryPurple110;
      case NoteVariants.errorNote:
        return appColor.statRedLightRed;
      case NoteVariants.infoNote:
        return appColor.clrPrimaryBlue110;
      case NoteVariants.plainText:
        return appColor.transparent;
      case NoteVariants.errorInfoNote:
        return appColor.statRedLightRed;
      case NoteVariants.warningInfoNote:
        return appColor.statLightAmber;
      default:
        return appColor.clrPrimaryPurple110;
    }
  }

  EdgeInsets? getMargin(final BuildContext context) {
    final size = context.theme.appSize;
    switch (this) {
      case NoteVariants.floatingNote:
        return EdgeInsets.symmetric(
          vertical: size.size16.dp,
          horizontal: size.size21.dp,
        );
      case NoteVariants.infoNote:
        return EdgeInsets.symmetric(
          horizontal: size.size21.dp,
        );
      default:
        return null;
    }
  }

  double getBorderRadius(final BuildContext context) {
    final size = context.theme.appSize;
    switch (this) {
      case NoteVariants.floatingNote:
        return size.size8.dp;
      case NoteVariants.infoNote:
        return size.size8.dp;
      case NoteVariants.errorInfoNote:
        return size.size8.dp;
      case NoteVariants.warningInfoNote:
        return size.size8.dp;
      default:
        return 0;
    }
  }

  TextStyle? getHeadingStyle(final BuildContext context) {
    final color = context.theme.appColor;
    final textStyle = context.theme.appTextStyles;
    switch (this) {
      case NoteVariants.floatingNote:
        return textStyle.bodyCopy2Small16Regular.copyWith(
          fontWeight: FontWeight.w600,
          color: color.clrPrimaryPurple,
        );
      case NoteVariants.richNote:
        return textStyle.labelSmall14Medium.copyWith(
          color: color.clrPrimaryPurple,
          fontWeight: FontWeight.w600,
        );
      case NoteVariants.note:
        return textStyle.labelSmall16Medium.copyWith(
          fontWeight: FontWeight.w600,
          color: color.clrPrimaryPurple,
        );
      case NoteVariants.errorNote:
        return textStyle.labelSmall14Medium.copyWith(
          fontWeight: FontWeight.w600,
          color: color.statRedDefault,
        );
      case NoteVariants.plainText:
        return textStyle.labelSmall14Medium.copyWith(
          fontWeight: FontWeight.w600,
          color: color.clrPrimaryPurple,
        );
      case NoteVariants.errorInfoNote:
        return textStyle.bodyCopy3Small14Regular.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: context.theme.appSize.size14.dp,
          color: color.statRedDark,
        );
      case NoteVariants.warningInfoNote:
        return textStyle.bodyCopy3Small14Regular.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: context.theme.appSize.size14.dp,
          color: color.statAmberDark,
        );
      default:
        return null;
    }
  }

  TextStyle? getDescriptionStyle(final BuildContext context) {
    final color = context.theme.appColor;
    final textStyle = context.theme.appTextStyles;
    switch (this) {
      case NoteVariants.floatingNote:
        return textStyle.bodyCopy2Small16Regular.copyWith(
          color: color.greyDarkestGrey20,
        );
      case NoteVariants.richNote:
        return textStyle.bodyCopy3Small14Regular.copyWith(
          color: color.greyBlackUi10,
          fontWeight: FontWeight.w400,
        );
      case NoteVariants.note:
        return textStyle.bodyCopy2Small16Regular.copyWith(
          color: color.greyBlackUi10,
        );

      case NoteVariants.errorNote:
        return textStyle.bodyCopy3Small14Regular.copyWith(
          color: color.greyBlackUi10,
          fontWeight: FontWeight.w400,
        );
      case NoteVariants.plainText:
        return textStyle.bodyCopy3Small14Regular.copyWith(
          color: color.greyMediumGrey40,
          fontWeight: FontWeight.w400,
        );
      case NoteVariants.infoNote:
        return textStyle.bodyCopy3Small14Regular.copyWith(
          color: color.clrPrimaryBlue,
          fontWeight: FontWeight.w400,
        );

      default:
        return null;
    }
  }

  TextStyle? getHighlightStyle(final BuildContext context) {
    final color = context.theme.appColor;
    final textStyle = context.theme.appTextStyles;
    switch (this) {
      case NoteVariants.floatingNote:
        return textStyle.bodyCopy2Small16Regular.copyWith(
          color: color.greyDarkestGrey20,
          fontWeight: FontWeight.w600,
        );
      case NoteVariants.richNote:
        return textStyle.bodyCopy3Small14Regular.copyWith(
          color: color.greyBlackUi10,
          fontWeight: FontWeight.w600,
        );
      case NoteVariants.note:
        return textStyle.bodyCopy2Small16Regular.copyWith(
          color: color.greyBlackUi10,
          fontWeight: FontWeight.w600,
        );

      case NoteVariants.errorNote:
        return textStyle.bodyCopy3Small14Regular.copyWith(
          color: color.greyBlackUi10,
          fontWeight: FontWeight.w600,
        );
      case NoteVariants.plainText:
        return textStyle.bodyCopy3Small14Regular.copyWith(
          color: color.greyMediumGrey40,
          fontWeight: FontWeight.w600,
        );
      default:
        return null;
    }
  }

  TextStyle? getHyperLinkStyle(final BuildContext context) {
    final color = context.theme.appColor;
    final textStyle = context.theme.appTextStyles;
    switch (this) {
      case NoteVariants.floatingNote:
        return textStyle.bodyCopy2Small16Regular.copyWith(
          fontWeight: FontWeight.w600,
          color: color.clrPrimaryPurple10,
          decoration: TextDecoration.underline,
        );
      case NoteVariants.richNote:
        return textStyle.bodyCopy3Small14Regular.copyWith(
          fontWeight: FontWeight.w600,
          color: color.clrPrimaryPurple10,
          decoration: TextDecoration.underline,
        );
      case NoteVariants.note:
        return textStyle.bodyCopy2Small16Regular.copyWith(
          fontWeight: FontWeight.w600,
          color: color.clrPrimaryPurple10,
          decoration: TextDecoration.underline,
        );

      case NoteVariants.errorNote:
        return textStyle.bodyCopy3Small14Regular.copyWith(
          fontWeight: FontWeight.w600,
          color: color.clrPrimaryPurple10,
          decoration: TextDecoration.underline,
        );
      case NoteVariants.plainText:
        return textStyle.bodyCopy3Small14Regular.copyWith(
          fontWeight: FontWeight.w600,
          color: color.clrPrimaryPurple10,
          decoration: TextDecoration.underline,
        );
      default:
        return null;
    }
  }

  String? getImagePath(final BuildContext context) {
    switch (this) {
      case NoteVariants.infoNote:
        return 'assets/images/info_note.svg';
      case NoteVariants.errorInfoNote:
        return 'assets/images/error_status_icn.svg';
      case NoteVariants.warningInfoNote:
        return 'assets/images/warning_note_icn.svg';
      default:
        return null;
    }
  }
}

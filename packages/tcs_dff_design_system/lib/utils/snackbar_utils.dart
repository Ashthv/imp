import 'package:flutter/material.dart';

import '../theme/theme.dart';
import '../uikit/foundation/snackbar/snack_bar_widget.dart';

enum SnackbarType {
  success,
  warning,
  error,
  successWarning,
  informative;

  Color getTextColor(final BuildContext context) {
    final appColor = context.theme.appColor;
    switch (this) {
      case SnackbarType.success:
        return appColor.greenDark;

      case SnackbarType.successWarning:
        return appColor.greenDark;

      case SnackbarType.error:
        return appColor.statRedDark;

      case SnackbarType.warning:
        return appColor.statAmberDark;
      case SnackbarType.informative:
        return appColor.clrPrimaryBlue;

      default:
        return appColor.clrPrimaryPurple10;
    }
  }

  Color getIconColor(final BuildContext context) {
    switch (this) {
      case SnackbarType.success:
        return context.theme.appColor.statGreenDefault;

      case SnackbarType.successWarning:
        return context.theme.appColor.statGreenDefault;

      case SnackbarType.error:
        return context.theme.appColor.statRedDark;

      case SnackbarType.warning:
        return context.theme.appColor.statAmber;

      case SnackbarType.informative:
        return context.theme.appColor.clrPrimaryBlue;

      default:
        return context.theme.appColor.clrPrimaryPurple10;
    }
  }

  Color getProgressBarColor(final BuildContext context) {
    switch (this) {
      case SnackbarType.success:
        return context.theme.appColor.statGreenDefault;

      case SnackbarType.successWarning:
        return context.theme.appColor.statGreenDefault;

      case SnackbarType.error:
        return context.theme.appColor.statRedDefault;

      case SnackbarType.warning:
        return context.theme.appColor.statAmber;

      case SnackbarType.informative:
        return context.theme.appColor.clrPrimaryBlue;

      default:
        return context.theme.appColor.clrPrimaryPurple10;
    }
  }

  Color getBackgroundColor(final BuildContext context) {
    switch (this) {
      case SnackbarType.success:
        return context.theme.appColor.statLightGreen;

      case SnackbarType.successWarning:
        return context.theme.appColor.statLightGreen;

      case SnackbarType.error:
        return context.theme.appColor.statRedLightRed;

      case SnackbarType.warning:
        return context.theme.appColor.statLightAmber;

      case SnackbarType.informative:
        return context.theme.appColor.clrPrimaryBlue110;

      default:
        return context.theme.appColor.clrPrimaryPurple30;
    }
  }

  Icon getIcon(final BuildContext context) {
    switch (this) {
      case SnackbarType.success:
        return Icon(
          Icons.check_circle_outline_outlined,
          color: getIconColor(context),
        );

      case SnackbarType.successWarning:
        return Icon(
          Icons.error_outline,
          color: getIconColor(context),
        );
      case SnackbarType.error:
        return Icon(
          Icons.error_outline,
          color: getIconColor(context),
        );

      case SnackbarType.warning:
        return Icon(
          Icons.error_outline,
          color: getIconColor(context),
        );

      case SnackbarType.informative:
        return Icon(
          Icons.info_outline,
          color: getIconColor(context),
        );

      default:
        return Icon(
          Icons.info_outline,
          color: getIconColor(context),
        );
    }
  }
}

void showSnackBar({
  required final BuildContext context,
  required final SnackbarType snackbarType,
  required final String message,
  final bool isDissmiss = false,
  final bool isAction = false,
  final String? actionCaption,
  final Function()? onActionTap,
  final Axis contentAxis = Axis.horizontal,
  final Duration? progressDuration,
  // final bool isSnackBarOnTop = false,
}) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: const Color(0x00ffffff),
      elevation: 0.0,
      // dismissDirection:
      //     isSnackBarOnTop ? DismissDirection.up : DismissDirection.down,
      // margin: isSnackBarOnTop
      //     ? EdgeInsets.only(
      //         bottom: MediaQuery.of(context).size.height -
      //             MediaQuery.of(context).padding.top,
      //         left: 10,
      //         right: 10,
      //       )
      //     : null,
      // behavior: isSnackBarOnTop ? SnackBarBehavior.floating : null,
      content: SnackBarWidget(
        snackbarType: snackbarType,
        message: message,
        contentAxis: contentAxis,
        isDissmiss: isDissmiss,
        isAction: isAction,
        onActionTap: onActionTap,
        actionCaption: actionCaption,
        progressDuration: progressDuration,
      ),
    ),
  );
}

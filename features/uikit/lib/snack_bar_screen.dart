import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';
import 'package:tcs_dff_design_system/utils/snackbar_utils.dart';
import 'package:tcs_dff_shared_library/localization/app_localizations.dart';

class SnackBarScreen extends StatelessWidget {
  const SnackBarScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    final color = context.theme.appColor;
    final size = context.theme.appSize;

    final locale = context.locale;
    final textStyle = context.theme.appTextStyles;
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    showSnackBar(
                      context: context,
                      snackbarType: SnackbarType.success,
                      message: locale.txt(key: 'successNotification'),
                    );
                  },
                  child: Text(
                    locale.txt(key: 'successSnackBar'),
                    style: textStyle.labelSmall18Medium.copyWith(
                      fontSize: size.size12.dp,
                      color: color.greyBlackUi10,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    showSnackBar(
                      context: context,
                      snackbarType: SnackbarType.success,
                      message: locale.txt(key: 'successNotification'),
                      isAction: true,
                      onActionTap: () {},
                      actionCaption: 'Action',
                    );
                  },
                  child: Text(
                    locale.txt(key: 'successSnackBarAction'),
                    style: textStyle.buttonMedium16SemiBold.copyWith(
                      fontSize: size.size12.dp,
                      color: color.greyBlackUi10,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    showSnackBar(
                      context: context,
                      snackbarType: SnackbarType.success,
                      message: locale.txt(key: 'SnackBarLongText'),
                    );
                  },
                  child: Text(
                    locale.txt(key: 'successSnackBar'),
                    style: textStyle.buttonMedium16SemiBold.copyWith(
                      fontSize: size.size12.dp,
                      color: color.greyBlackUi10,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    showSnackBar(
                      context: context,
                      snackbarType: SnackbarType.success,
                      message: locale.txt(key: 'SnackBarLongText'),
                      contentAxis: Axis.vertical,
                      isAction: true,
                      onActionTap: () {},
                      actionCaption: 'Action',
                    );
                  },
                  child: Text(
                    locale.txt(key: 'successSnackBarAction'),
                    style: textStyle.buttonMedium16SemiBold.copyWith(
                      fontSize: size.size12.dp,
                      color: color.greyBlackUi10,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    showSnackBar(
                      context: context,
                      snackbarType: SnackbarType.successWarning,
                      message: locale.txt(key: 'SnackBarLongText'),
                      contentAxis: Axis.vertical,
                      isDissmiss: true,
                      progressDuration: const Duration(seconds: 4),
                    );
                  },
                  child: Text(
                    locale.txt(key: 'successSnackBarDismiss'),
                    style: textStyle.buttonMedium16SemiBold.copyWith(
                      fontSize: size.size12.dp,
                      color: color.greyBlackUi10,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => showSnackBar(
                    context: context,
                    snackbarType: SnackbarType.warning,
                    message: locale.txt(key: 'pendingNotification'),
                  ),
                  child: Text(
                    locale.txt(key: 'pendingSnackBar'),
                    style: textStyle.buttonMedium16SemiBold.copyWith(
                      fontSize: size.size12.dp,
                      color: color.greyBlackUi10,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => showSnackBar(
                    context: context,
                    snackbarType: SnackbarType.warning,
                    message: locale.txt(key: 'pendingNotification'),
                    isAction: true,
                    onActionTap: () {},
                    actionCaption: 'Action',
                  ),
                  child: Text(
                    locale.txt(key: 'pendingSnackBarAction'),
                    style: textStyle.buttonMedium16SemiBold.copyWith(
                      fontSize: size.size12.dp,
                      color: color.greyBlackUi10,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    showSnackBar(
                      context: context,
                      snackbarType: SnackbarType.warning,
                      message: locale.txt(key: 'SnackBarLongText'),
                    );
                  },
                  child: Text(
                    locale.txt(key: 'pendingSnackBar'),
                    style: textStyle.buttonMedium16SemiBold.copyWith(
                      fontSize: size.size12.dp,
                      color: color.greyBlackUi10,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    showSnackBar(
                      context: context,
                      snackbarType: SnackbarType.warning,
                      message: locale.txt(key: 'SnackBarLongText'),
                      contentAxis: Axis.vertical,
                      isAction: true,
                      onActionTap: () {},
                      actionCaption: 'Action',
                    );
                  },
                  child: Text(
                    locale.txt(key: 'pendingSnackBarAction'),
                    style: textStyle.buttonSmall14SemiBold.copyWith(
                      fontSize: size.size12.dp,
                      color: color.greyBlackUi10,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => showSnackBar(
                    context: context,
                    snackbarType: SnackbarType.warning,
                    message: locale.txt(key: 'SnackBarLongText'),
                    contentAxis: Axis.vertical,
                    isDissmiss: true,
                    progressDuration: const Duration(seconds: 4),
                  ),
                  child: Text(
                    locale.txt(key: 'pendingSnackBarDismiss'),
                    style: textStyle.buttonMedium16SemiBold.copyWith(
                      fontSize: size.size12.dp,
                      color: color.greyBlackUi10,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () => showSnackBar(
                    context: context,
                    snackbarType: SnackbarType.error,
                    message: locale.txt(key: 'errorNotification'),
                  ),
                  child: Text(
                    locale.txt(key: 'errorSnackBar'),
                    style: textStyle.labelSmall18Medium.copyWith(
                      fontSize: size.size12.dp,
                      color: color.greyBlackUi10,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => showSnackBar(
                    context: context,
                    snackbarType: SnackbarType.error,
                    message: locale.txt(key: 'errorNotification'),
                    isAction: true,
                    onActionTap: () {},
                    actionCaption: 'Action',
                  ),
                  child: Text(
                    locale.txt(key: 'errorSnackBarAction'),
                    style: textStyle.buttonMedium16SemiBold.copyWith(
                      fontSize: size.size12.dp,
                      color: color.greyBlackUi10,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => showSnackBar(
                    context: context,
                    snackbarType: SnackbarType.error,
                    message: locale.txt(key: 'SnackBarLongText'),
                  ),
                  child: Text(
                    locale.txt(key: 'errorSnackBar'),
                    style: textStyle.buttonMedium16SemiBold.copyWith(
                      fontSize: size.size12.dp,
                      color: color.greyBlackUi10,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => showSnackBar(
                    context: context,
                    snackbarType: SnackbarType.error,
                    message: locale.txt(key: 'SnackBarLongText'),
                    contentAxis: Axis.vertical,
                    isAction: true,
                    onActionTap: () {},
                    actionCaption: 'Action',
                  ),
                  child: Text(
                    locale.txt(key: 'errorSnackBarAction'),
                    style: textStyle.buttonMedium16SemiBold.copyWith(
                      fontSize: size.size12.dp,
                      color: color.greyBlackUi10,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => showSnackBar(
                    context: context,
                    snackbarType: SnackbarType.error,
                    message: locale.txt(key: 'SnackBarLongText'),
                    contentAxis: Axis.vertical,
                    isDissmiss: true,
                    progressDuration: const Duration(seconds: 4),
                  ),
                  child: Text(
                    locale.txt(key: 'errorSnackBarDismiss'),
                    style: textStyle.buttonMedium16SemiBold.copyWith(
                      fontSize: size.size12.dp,
                      color: color.greyBlackUi10,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => showSnackBar(
                    context: context,
                    snackbarType: SnackbarType.informative,
                    message: locale.txt(key: 'infoNotification'),
                  ),
                  child: Text(
                    locale.txt(key: 'infoSnackBar'),
                    style: textStyle.buttonMedium16SemiBold.copyWith(
                      fontSize: size.size12.dp,
                      color: color.greyBlackUi10,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => showSnackBar(
                    context: context,
                    snackbarType: SnackbarType.informative,
                    message: locale.txt(key: 'infoNotification'),
                    isAction: true,
                    actionCaption: 'Action',
                    // isSnackBarOnTop: true,
                  ),
                  child: Text(
                    locale.txt(key: 'infoSnackBarAction'),
                    style: textStyle.buttonMedium16SemiBold.copyWith(
                      fontSize: size.size12.dp,
                      color: color.greyBlackUi10,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => showSnackBar(
                    context: context,
                    snackbarType: SnackbarType.informative,
                    message: locale.txt(key: 'SnackBarLongText'),
                  ),
                  child: Text(
                    locale.txt(key: 'infoSnackBar'),
                    style: textStyle.buttonMedium16SemiBold.copyWith(
                      fontSize: size.size12.dp,
                      color: color.greyBlackUi10,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => showSnackBar(
                    context: context,
                    snackbarType: SnackbarType.informative,
                    message: locale.txt(key: 'SnackBarLongText'),
                    contentAxis: Axis.vertical,
                    isAction: true,
                    onActionTap: () {},
                    actionCaption: 'Action',
                    // isSnackBarOnTop: true,
                  ),
                  child: Text(
                    locale.txt(key: 'infoSnackBarAction'),
                    style: textStyle.buttonMedium16SemiBold.copyWith(
                      fontSize: size.size12.dp,
                      color: color.greyBlackUi10,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../../utils/sizer/app_sizer.dart';
import '../foundation/icon_widget.dart';

class NotificationWidget extends StatelessWidget {
  final String icon;
  final String? package;
  final NotificationType notificationType;
  final String message;
  final VoidCallback onClick;
  const NotificationWidget({
    super.key,
    required this.icon,
    this.package,
    required this.notificationType,
    required this.message,
    required this.onClick,
  });

  @override
  Widget build(final BuildContext context) {
    Color _getBorderColor() {
      if (notificationType.name == NotificationType.success.name) {
        return context.theme.appColor.transparent;
      } else if (notificationType.name == NotificationType.error.name) {
        return context.theme.appColor.statRedDefault;
      } else if (notificationType.name == NotificationType.warning.name) {
        return context.theme.appColor.statAmberDark;
      } else if (notificationType.name == NotificationType.informative.name) {
        return context.theme.appColor.clrPrimaryBlue;
      }
      return context.theme.appColor.clrPrimaryPurple90;
    }

    Color _getTextColor() {
      if (notificationType.name == NotificationType.success.name) {
        return context.theme.appColor.greenDark;
      } else if (notificationType.name == NotificationType.error.name) {
        return context.theme.appColor.statRedDefault;
      } else if (notificationType.name == NotificationType.warning.name) {
        return context.theme.appColor.statAmberDark;
      } else if (notificationType.name == NotificationType.informative.name) {
        return context.theme.appColor.clrPrimaryBlue;
      }
      return context.theme.appColor.clrPrimaryPurple90;
    }

    Color _getBackgroundColor() {
      if (notificationType.name == NotificationType.success.name) {
        return context.theme.appColor.statLightGreen;
      } else if (notificationType.name == NotificationType.error.name) {
        return context.theme.appColor.statRedLightRed;
      } else if (notificationType.name == NotificationType.warning.name) {
        return context.theme.appColor.statLightAmber;
      } else if (notificationType.name == NotificationType.informative.name) {
        return context.theme.appColor.clrPrimaryBlue110;
      }
      return context.theme.appColor.clrPrimaryPurple90;
    }

    return Container(
      padding: EdgeInsets.all(context.theme.appSize.size12.dp),
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        border: Border.all(
          color: _getBorderColor(),
          width: context.theme.appSize.size1.dp,
        ),
        borderRadius: BorderRadius.circular(context.theme.appSize.size6.dp),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconWidget(
              iconName: icon,
              package: package,
              iconSize: IconSize.small,
              iconColor: _getTextColor(),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: context.theme.appSize.size8.dp),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    overflow: TextOverflow.clip,
                    message,
                    style: context.theme.appTextStyles.bodyCopy3Small14Regular
                        .copyWith(
                      color: _getTextColor(),
                    ),
                  ),
                ),
              ),
            ),
            IconWidget(
              iconName:
                  'packages/tcs_dff_design_system/assets/images/close.png',
              iconSize: IconSize.small,
              onPressed: onClick,
              iconColor: context.theme.appColor.greyGrey50,
            ),
          ],
        ),
      ),
    );
  }
}

enum NotificationType {
  success,
  warning,
  error,
  informative,
}

import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/uikit/container/notification_widget.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';
import 'package:tcs_dff_shared_library/localization/app_localizations.dart';

class NotificationWidgetScreen extends StatelessWidget {
  const NotificationWidgetScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final locale = context.locale;
    return Scaffold(
      body: Column(
        children: <Widget>[
          NotificationWidget(
            icon: 'packages/uikit/images/error.png',
            notificationType: NotificationType.success,
            message: locale.txt(key: 'emptyMessage'),
            onClick: () {},
          ),
          SizedBox(
            height: size.size8.dp,
          ),
          NotificationWidget(
            icon: 'packages/uikit/images/error.png',
            notificationType: NotificationType.warning,
            message: locale.txt(key: 'emptyMessage'),
            onClick: () {},
          ),
          SizedBox(
            height: size.size8.dp,
          ),
          NotificationWidget(
            icon: 'packages/uikit/images/error.png',
            notificationType: NotificationType.error,
            message: locale.txt(key: 'emptyMessage'),
            onClick: () {},
          ),
          SizedBox(
            height: size.size8.dp,
          ),
          NotificationWidget(
            icon: 'packages/uikit/images/error.png',
            notificationType: NotificationType.informative,
            message: locale.txt(key: 'emptyMessage'),
            onClick: () {},
          ),
          SizedBox(
            height: size.size8.dp,
          ),
          NotificationWidget(
            icon: 'packages/uikit/images/error.png',
            notificationType: NotificationType.success,
            message: locale.txt(key: 'emptyMessage'),
            onClick: () {},
          ),
        ],
      ),
    );
  }
}

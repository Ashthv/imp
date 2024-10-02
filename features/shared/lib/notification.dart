import 'package:tcs_dff_device_feature/notification/firebase_notification_plugin.dart';
import 'package:tcs_dff_route/tcs_dff_route.dart';
import 'package:tcs_dff_types/platform.dart';

void initNotificationHandlers() {
  dff.notification.onForegroundNotification(onRecieveForegroundHandler);

  dff.notification
      .onBackgroundTerminateNotification(onReceiveBackgroundTerminateHandler);

  dff.notification.onBackgroundNotificationOpen(onOpenBackgroundHandler);

  onOpenTerminateHandler();
}

Future<void> onRecieveForegroundHandler(
  final NotificationData notificationData,
) async {
  dff.notification.showNotification(notificationData);
}

@pragma('vm:entry-point')
Future<void> onReceiveBackgroundTerminateHandler(
  final NotificationData notificationData,
) async {
  dff.notification.showNotification(notificationData);
}

Future<void> onOpenBackgroundHandler(
  final NotificationData notificationData,
) async {
  final routePath = notificationData.data['route'] as String;
  RouteNavigator.push(rootNavigatorKey.currentContext!, routePath);
}

Future<void> onOpenTerminateHandler() async {
  final notificationData =
      await dff.notification.getNotificationOpenOnTerminate();

  if (notificationData != null) {
    final routePath = notificationData.data['route'] as String;
    RouteNavigator.push(rootNavigatorKey.currentContext!, routePath);
  }
}

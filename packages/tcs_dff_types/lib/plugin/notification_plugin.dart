import 'dart:async';

import 'package:tcs_dff_device_feature/notification/firebase_notification_plugin.dart';

import 'plugin_types.dart';

/// Funtion signature of callback for incoming notifications received
/// while app is in foreground, background or terminated
typedef MessageHandler = Future<void> Function(NotificationData data);

abstract interface class NotificationPlugin implements Plugin {
  /// Get notification token
  Future<String?> getToken();

  /// Listen for incoming notifications received while app is in foreground
  void onForegroundNotification(final MessageHandler handler);

  /// Notification handler function which is called when the app is in the
  /// background or terminated state.
  void onBackgroundTerminateNotification(final MessageHandler handler);

  /// Returns notification opened from terminated state otherwise null
  Future<NotificationData?> getNotificationOpenOnTerminate();

  /// Listen to notifications opened while app is in background
  void onBackgroundNotificationOpen(final MessageHandler handler);

  /// Request notification permissions
  Future<void> requestNotificationPermissions();

  /// Setup platform respective notification configuration
  Future<void> setupPlatformNotificationConfig();

  /// Show notification
  void showNotification(final NotificationData data);
}

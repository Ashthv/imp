import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tcs_dff_types/tcs_dff_types.dart';

import '../permission/device_permission_manager.dart';
import '../permission/permission_types.dart';
import '../utils/string_constants.dart';

typedef NotificationData = RemoteMessage;

class FirebaseNotificationPlugin implements NotificationPlugin {
  FirebaseNotificationPlugin({
    required this.currentFirebaseOptions,
    this.name,
    required this.initNotificationHandlers,
  });

  final FirebaseOptions currentFirebaseOptions;
  final String? name;
  final void Function() initNotificationHandlers;

  late final FirebaseMessaging instance;
  late final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  late final AndroidNotificationChannel channel;

  @override
  Future<void> init() async {
    await Firebase.initializeApp(
      options: currentFirebaseOptions,
      name: name,
    );
    instance = FirebaseMessaging.instance;
    instance.onTokenRefresh.listen(cacheToken);
    await setupPlatformNotificationConfig();
    initNotificationHandlers.call();
  }

  @override
  Future<String?> getToken() async {
    var notificationToken = await dff.storage.getItem<String>(
      collectionName: token,
      key: notification,
    );

    if (notificationToken == null) {
      notificationToken = await instance.getToken();

      if (notificationToken != null) {
        await cacheToken(notificationToken);
      }
    }

    return notificationToken;
  }

  Future<void> cacheToken(final String notificationToken) async {
    await dff.storage.setItem<String>(
      collectionName: token,
      key: notification,
      item: notificationToken,
    );
  }

  @override
  Future<void> requestNotificationPermissions() async {
    final devicePermissionManager = DevicePermissionManager();
    final status = await devicePermissionManager.checkAndRequestPermission(
      DevicePermission.notification,
    );

    if (!status.isGranted) {
      throw DevicePermissionException(
        error:
            Error(title: permissionDenyMessage, description: status.toString()),
      );
    }
  }

  @override
  Future<NotificationData?> getNotificationOpenOnTerminate() =>
      instance.getInitialMessage();

  @override
  void onBackgroundTerminateNotification(final MessageHandler handler) =>
      FirebaseMessaging.onBackgroundMessage(handler);

  @override
  void onForegroundNotification(final MessageHandler handler) {
    FirebaseMessaging.onMessage.listen(handler);
  }

  @override
  void onBackgroundNotificationOpen(final MessageHandler handler) {
    FirebaseMessaging.onMessageOpenedApp.listen(handler);
  }

  @override
  Future<void> setupPlatformNotificationConfig() async {
    channel = const AndroidNotificationChannel(
      notificationChannelId,
      notificationChannelName,
      description: notificationChannelDescription,
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  @override
  void showNotification(final NotificationData data) {
    final notification = data.notification;
    if (notification != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            importance: channel.importance,
            // Get icon from below path
            // "apps\framework_demo\android\app\src\main\res\drawable\launch_background.xml".
            icon: 'launch_background',
          ),
        ),
      );
    }
  }

  @override
  Future<void> release() async {
    await instance.setAutoInitEnabled(false);
    await instance.deleteToken();
  }
}

// TODO: Refer below documentations for IOS setup
// https://firebase.flutter.dev/docs/messaging/apple-integration/
// https://firebase.google.com/docs/cloud-messaging/flutter/client 
// https://pub.dev/packages/flutter_local_notifications#-ios-setup

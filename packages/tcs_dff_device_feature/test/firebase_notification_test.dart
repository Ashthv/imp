import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tcs_dff_device_feature/notification/firebase_notification_plugin.dart';
import 'package:tcs_dff_device_feature/utils/string_constants.dart';
import 'package:tcs_dff_test/dff_mocks.dart';
import 'package:tcs_dff_types/tcs_dff_types.dart';

import 'firebase_options.dart';
import 'notification_mock.dart';

void main() {
  FirebaseNotificationPlugin? notification;

  setUp(() async {
    setupFirebaseNotificationMocks();
    if (notification == null) {
      notification = FirebaseNotificationPlugin(
        name: 'firebase_notification',
        currentFirebaseOptions: DefaultFirebaseOptions.firebaseOptions,
        initNotificationHandlers: () {},
      );
      await notification!.init();
    }
    dff = MockDffPlatform();
  });

  group('setupPlatformNotificationConfig', () {
    tearDown(methodCallLog.clear);
    test('verify create android notification channel', () async {
      expect(
        methodCallLog,
        <Matcher>[
          isMethodCall(
            'createNotificationChannel',
            arguments: {
              'id': notificationChannelId,
              'name': notificationChannelName,
              'description': notificationChannelDescription,
              'importance': Importance.high.value,
              'groupId': null,
              'showBadge': true,
              'playSound': true,
              'enableVibration': true,
              'vibrationPattern': null,
              'enableLights': false,
              'ledColorAlpha': null,
              'ledColorRed': null,
              'ledColorGreen': null,
              'ledColorBlue': null,
              'channelAction':
                  AndroidNotificationChannelAction.createIfNotExists.index,
            },
          ),
        ],
        reason: 'android notification channel value doesnt match',
      );
    });
  });

  group('requestNotificationPermissions', () {
    tearDown(methodCallLog.clear);
    test('check notification permission', () async {
      DevicePermissionException? exception;
      try {
        await notification!.requestNotificationPermissions();
      } on DevicePermissionException catch (e) {
        exception = e;
      }
      expect(
        exception == null,
        true,
        reason: 'permission status should not throw exception as its granted',
      );
    });
  });

  group('getToken', () {
    tearDown(methodCallLog.clear);
    test('verify notification token from cache', () async {
      when(
        () => dff.storage.getItem<String>(
          collectionName: any(named: 'collectionName'),
          key: any(named: 'key'),
        ),
      ).thenAnswer((final _) async => Future.value('Su78@jhg88'));
      final cachedNotificationToken = await notification!.getToken();
      expect(
        cachedNotificationToken != null,
        true,
        reason: 'cached notification token should not be null',
      );
    });

    test('verify notification token via generation', () async {
      when(
        () => dff.storage.getItem<String>(
          collectionName: any(named: 'collectionName'),
          key: any(named: 'key'),
        ),
      ).thenAnswer((final _) async => Future.value());
      when(
        () => dff.storage.setItem<String>(
          collectionName: any(named: 'collectionName'),
          key: any(named: 'key'),
          item: any(named: 'item'),
        ),
      ).thenAnswer((final _) async => Future.value());
      final cachedNotificationToken = await notification!.getToken();

      expect(
        cachedNotificationToken != null,
        true,
        reason: 'cached token should not be null',
      );
    });

    test('cacheToken', () async {
      when(
        () => dff.storage.setItem<String>(
          collectionName: any(named: 'collectionName'),
          key: any(named: 'key'),
          item: any(named: 'item'),
        ),
      ).thenAnswer((final _) async => Future.value());
      await notification!.cacheToken('any');
    });

    // test('verify notification token from api', () async {
    //   when(
    //     () => dff.storage.getItem<String>(
    //       collectionName: any(named: 'collectionName'),
    //       key: any(named: 'key'),
    //     ),
    //   ).thenAnswer((final _) async => Future.value());
    //   when(
    //     () => dff.storage.setItem<String>(
    //       collectionName: any(named: 'collectionName'),
    //       key: any(named: 'key'),
    //       item: any(named: 'item'),
    //     ),
    //   ).thenAnswer((final _) async => Future.value());
    //   final notificationToken = await notification!.getToken();
    //   expect(
    //     notificationToken != null,
    //     true,
    //     reason: 'notification token should not be null',
    //   );
    // });
  });

  group('showNotification', () {
    tearDown(methodCallLog.clear);
    test('check show notification', () async {
      const notificationData = NotificationData(
        notification: RemoteNotification(
          title: 'Test Title',
          body: 'Test Body',
        ),
      );
      notification!.showNotification(notificationData);
      expect(
        methodCallLog,
        <Matcher>[
          isMethodCall(
            'show',
            arguments: <String, dynamic>{
              'id': notificationData.notification.hashCode,
              'title': 'Test Title',
              'body': 'Test Body',
              'payload': '',
              'platformSpecifics': {
                'icon': 'launch_background',
                'channelId': 'notification_channel',
                'channelName': 'Notification Channel',
                'channelDescription': 'Notification Description',
                'channelShowBadge': true,
                'channelAction': 0,
                'importance': 4,
                'priority': 0,
                'playSound': true,
                'enableVibration': true,
                'vibrationPattern': null,
                'groupKey': null,
                'setAsGroupSummary': false,
                'groupAlertBehavior': 0,
                'autoCancel': true,
                'ongoing': false,
                'silent': false,
                'colorAlpha': null,
                'colorRed': null,
                'colorGreen': null,
                'colorBlue': null,
                'onlyAlertOnce': false,
                'showWhen': true,
                'when': null,
                'usesChronometer': false,
                'chronometerCountDown': false,
                'showProgress': false,
                'maxProgress': 0,
                'progress': 0,
                'indeterminate': false,
                'enableLights': false,
                'ledColorAlpha': null,
                'ledColorRed': null,
                'ledColorGreen': null,
                'ledColorBlue': null,
                'ledOnMs': null,
                'ledOffMs': null,
                'ticker': null,
                'visibility': null,
                'timeoutAfter': null,
                'category': null,
                'fullScreenIntent': false,
                'shortcutId': null,
                'additionalFlags': null,
                'subText': null,
                'tag': null,
                'colorized': false,
                'number': null,
                'audioAttributesUsage': 5,
                'style': 0,
                'styleInformation': {
                  'htmlFormatContent': false,
                  'htmlFormatTitle': false,
                },
              },
            },
          ),
        ],
        reason: 'notification data doesnt match',
      );
    });
  });

  group('Overriden methods', () {
    test('getNotificationOpenOnTerminate', () async {
      final remoteMessageResult =
          notification!.getNotificationOpenOnTerminate();

      expect(remoteMessageResult, isNotNull);
    });
  });
}

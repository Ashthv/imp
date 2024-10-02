import 'dart:core';

import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:firebase_crashlytics_platform_interface/firebase_crashlytics_platform_interface.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

typedef Callback = void Function(MethodCall call);

final List methodCallLog = [];

class MockFirebaseAppWithCollectionEnabled implements TestFirebaseCoreHostApi {
  @override
  Future<PigeonInitializeResponse> initializeApp(
    final String appName,
    final PigeonFirebaseOptions initializeAppRequest,
  ) async =>
      PigeonInitializeResponse(
        name: appName,
        options: PigeonFirebaseOptions(
          apiKey: '123',
          projectId: '123',
          appId: '123',
          messagingSenderId: '123',
        ),
        pluginConstants: {
          'plugins.flutter.io/firebase_crashlytics': {
            'isCrashlyticsCollectionEnabled': true,
          },
        },
      );

  @override
  Future<List<PigeonInitializeResponse?>> initializeCore() async => [
        PigeonInitializeResponse(
          name: defaultFirebaseAppName,
          options: PigeonFirebaseOptions(
            apiKey: '123',
            projectId: '123',
            appId: '123',
            messagingSenderId: '123',
          ),
          pluginConstants: {
            'plugins.flutter.io/firebase_crashlytics': {
              'isCrashlyticsCollectionEnabled': true,
            },
          },
        ),
      ];

  @override
  Future<PigeonFirebaseOptions> optionsFromResource() async =>
      PigeonFirebaseOptions(
        apiKey: '123',
        projectId: '123',
        appId: '123',
        messagingSenderId: '123',
      );
}

void setupFirebaseCrashlyticsMocks([final Callback? customHandlers]) {
  TestWidgetsFlutterBinding.ensureInitialized();

  TestFirebaseCoreHostApi.setup(MockFirebaseAppWithCollectionEnabled());

  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(MethodChannelFirebaseCrashlytics.channel,
          (final MethodCall methodCall) async {
    methodCallLog.add(methodCall);
    switch (methodCall.method) {
      case 'Crashlytics#checkForUnsentReports':
        return {
          'unsentReports': true,
        };
      // case 'Crashlytics#setCrashlyticsCollectionEnabled':
      //   return {
      //     'isCrashlyticsCollectionEnabled': methodCall.arguments['enabled']
      //   };
      case 'Crashlytics#didCrashOnPreviousExecution':
        return {
          'didCrashOnPreviousExecution': true,
        };
      case 'Crashlytics#recordError':
        return null;
      default:
        return false;
    }
  });
}

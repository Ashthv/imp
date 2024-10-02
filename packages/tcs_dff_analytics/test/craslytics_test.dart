import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tcs_dff_analytics/crashlytics/firebase_crashlytics_plugin.dart';
import 'package:tcs_dff_shared_library/uncaught_error/uncaught_error.dart';
import 'package:tcs_dff_types/exceptions.dart';

import 'crashlytics_mock.dart';
import 'firebase_options.dart';

class MockFirebaseCrashlytics extends Mock implements FirebaseCrashlytics {}

class FakeFlutterErrorDetails extends Fake implements FlutterErrorDetails {
  @override
  String toString({final DiagnosticLevel minLevel = DiagnosticLevel.info}) =>
      'FakeFlutterErrorDetails';
}

class MockUncaughtError extends Mock implements UncaughtError {}

void main() {
  setupFirebaseCrashlyticsMocks();
  FirebaseCrashlyticsPlugin? crashlytics;
  final mockInstance = MockFirebaseCrashlytics();
  late MockUncaughtError mockUncaughtError;
  group('$FirebaseCrashlytics', () {
    setUpAll(() async {
      crashlytics = FirebaseCrashlyticsPlugin(
        name: 'crashlytics_test',
        currentFirebaseOptions: DefaultFirebaseOptions.firebaseOptions,
      );
      await crashlytics!.init();
      mockUncaughtError = MockUncaughtError();

      crashlytics?.instance = mockInstance;
      crashlytics?.uncaughtErrorInstance = mockUncaughtError;
      registerFallbackValue(FakeFlutterErrorDetails());
      registerFallbackValue(StackTrace.current);
    });

    setUp(() async {
      methodCallLog.clear();
    });

    group('recordError', () {
      tearDown(methodCallLog.clear);
      test('release calls UncaughtError().unregisterListener ', () async {
        await crashlytics?.release();

        verify(
          () => mockUncaughtError.unregisterListener(
            crashlytics as UncaughtErrorCallback,
          ),
        ).called(1);
      });
      test('setCustomKey calls instance.setCustomKey', () async {
        when(() => mockInstance.setCustomKey(any(), any()))
            .thenAnswer((final _) async {});

        await crashlytics?.setCustomKey(key: 'test_key', value: 'test_value');

        verify(() => mockInstance.setCustomKey('test_key', 'test_value'))
            .called(1);
      });

      test('logMessage calls instance.log', () {
        when(() => mockInstance.log(any())).thenAnswer(Future.value);

        crashlytics?.logMessage(message: 'Test message');

        verify(() => mockInstance.log('Test message')).called(1);
      });

      test('setUserIdentifier calls instance.setUserIdentifier', () async {
        when(() => mockInstance.setUserIdentifier(any()))
            .thenAnswer((final _) async {});

        await crashlytics?.setUserIdentifier(id: 'test_id');

        verify(() => mockInstance.setUserIdentifier('test_id')).called(1);
      });

      test('flutterErrorCallback calls recordFlutterError ', () async {
        final errorDetails = FlutterErrorDetails(
          exception: Exception('Test Error'),
          stack: StackTrace.current,
          informationCollector: () => {},
        );

        when(() => mockInstance.recordFlutterError(any()))
            .thenAnswer(Future.value);

        crashlytics?.flutterErrorCallback(errorDetails);

        verify(
          () => mockInstance.recordFlutterError(
            errorDetails,
          ),
        ).called(1);
      });

      test('platformErrorCallback calls recordError ', () {
        final testException = Exception('Test Error');
        final testStackTrace = StackTrace.current;

        // Mock the recordError behavior
        when(
          () => mockInstance.recordError(
            any(),
            any(),
            fatal: any(named: 'fatal'),
            reason: any(named: 'reason'),
          ),
        ).thenAnswer(Future.value);

        crashlytics?.platformErrorCallback(testException, testStackTrace);

        verify(
          () => mockInstance.recordError(
            testException,
            testStackTrace,
            reason: any(named: 'reason'),
          ),
        ).called(1);
      });
    });
  });
}

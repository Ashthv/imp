import 'package:flutter_test/flutter_test.dart';
import 'package:tcs_dff_analytics/analytics/firebase_default_analytics.dart';
import '../test/firebase_options.dart';
import 'analytics_mock.dart';

void main() {
  setupFirebaseAnalyticsMocks();
  FirebaseAnalyticsPlugin? analytics;
  group('$FirebaseAnalyticsPlugin', () {
    setUpAll(() async {
      analytics = FirebaseAnalyticsPlugin(
        name: 'firebase_test',
        currentFirebaseOptions: DefaultFirebaseOptions.firebaseOptions,
      );
      await analytics!.init();
    });
    tearDown(methodCallLog.clear);
  });

  group('logEvent', () {
    tearDown(methodCallLog.clear);

    test('custom event with correct parameters', () {
      analytics!.logEvent(
        eventName: 'test-event',
        parameters: {'a': 'b'},
      );
      expect(
        methodCallLog,
        <Matcher>[
          isMethodCall(
            'Analytics#logEvent',
            arguments: {
              'eventName': 'test-event',
              'parameters': {'a': 'b'},
            },
          ),
        ],
      );
    });
  });
  group('Non logEvent type API', () {
    tearDown(methodCallLog.clear);
    test('setUserId', () {
      analytics!.setUserId(
        id: 'test-user-id',
      );
      expect(
        methodCallLog,
        <Matcher>[
          isMethodCall(
            'Analytics#setUserId',
            arguments: {'userId': 'test-user-id'},
          ),
        ],
      );
    });

    test('setUserProperty', () {
      analytics!.setUserProperty(
        name: 'test_name',
        value: 'test-value',
      );
      expect(
        methodCallLog,
        <Matcher>[
          isMethodCall(
            'Analytics#setUserProperty',
            arguments: <String, String>{
              'name': 'test_name',
              'value': 'test-value',
            },
          ),
        ],
      );
    });
    test('setDefaultEventParameters should add defaultParameters', () {
      final parameters = <String, dynamic>{
        'param1': 'value3',
        'param2': 'value4',
      };

      analytics!.setDefaultEventParameters(parameters: parameters);
      expect(
        methodCallLog,
        <Matcher>[
          isMethodCall(
            'Analytics#setDefaultEventParameters',
            arguments: {
              'param1': 'value3',
              'param2': 'value4',
              'test': 'test',
              'string_parameter': 'string',
              'int_parameter': 42,
              'version': '1.0.4',
            },
          ),
        ],
      );
    });
  });
}

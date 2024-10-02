import 'package:flutter_test/flutter_test.dart';
import 'package:tcs_dff_test/dff_mocks.dart';

void main() {
  late MockDffPlatform platform;

  group('Mock Dff Platform', () {
    setUp(() => platform = MockDffPlatform());

    test('set network plugin', () {
      final n = MockNetworkPlugin();
      expect(platform.network == n, false);
      platform.network = n;
      expect(platform.network == n, true);
    });

    test('set storage plugin', () {
      final s = MockStoragePlugin();
      expect(platform.storage == s, false);
      platform.storage = s;
      expect(platform.storage == s, true);
    });

    test('set di plugin', () {
      final di = MockDependencyInjectionPlugin();
      expect(platform.di == di, false);
      platform.di = di;
      expect(platform.di == di, true);
    });

    test('set analytics plugin', () {
      final a = MockAnalyticsPlugin();
      expect(platform.analytics == a, false);
      platform.analytics = a;
      expect(platform.analytics == a, true);
    });

    test('set crashlytics plugin', () {
      final c = MockCrashlyticsPlugin();
      expect(platform.crashlytics == c, false);
      platform.crashlytics = c;
      expect(platform.crashlytics == c, true);
    });

    test('set notification plugin', () {
      final n = MockNotificationPlugin();
      expect(platform.notification == n, false);
      platform.notification = n;
      expect(platform.notification == n, true);
    });

    test('set sharedpref plugin', () {
      final s = MockSharedPreferencePlugin();
      expect(platform.sharedPreferences == s, false);
      platform.sharedPreferences = s;
      expect(platform.sharedPreferences == s, true);
    });
  });
}

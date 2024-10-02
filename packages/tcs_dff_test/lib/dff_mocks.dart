import 'package:mocktail/mocktail.dart';
import 'package:tcs_dff_device_feature/location/user_location.dart';
import 'package:tcs_dff_device_feature/sms_feature/sms_feature.dart';
import 'package:tcs_dff_device_feature/unique_device_id/unique_device_id.dart';
import 'package:tcs_dff_network/http_auth_network.dart';
import 'package:tcs_dff_types/plugin/device_info_plugin.dart';
import 'package:tcs_dff_types/tcs_dff_types.dart';

class MockDffPlatform extends Mock implements DffPlatform {
  MockDffPlatform();

  AnalyticsPlugin _analytics = MockAnalyticsPlugin();
  DependencyInjectionPlugin _di = MockDependencyInjectionPlugin();
  StoragePlugin _storage = MockStoragePlugin();
  NetworkPlugin _network = MockNetworkPlugin();
  CrashlyticsPlugin _crashlytics = MockCrashlyticsPlugin();
  SharedPreferencePlugin _sharedPreference = MockSharedPreferencePlugin();
  NotificationPlugin _notification = MockNotificationPlugin();

  @override
  StoragePlugin get storage => _storage;
  set storage(final StoragePlugin storage) => _storage = storage;

  @override
  SharedPreferencePlugin get sharedPreferences => _sharedPreference;
  set sharedPreferences(final SharedPreferencePlugin sharedPreferences) =>
      _sharedPreference = sharedPreferences;

  @override
  AnalyticsPlugin get analytics => _analytics;
  set analytics(final AnalyticsPlugin analytics) => _analytics = analytics;

  @override
  DependencyInjectionPlugin get di => _di;
  set di(final DependencyInjectionPlugin di) => _di = di;

  @override
  NetworkPlugin get network => _network;
  set network(final NetworkPlugin network) => _network = network;
  @override
  CrashlyticsPlugin get crashlytics => _crashlytics;
  set crashlytics(final CrashlyticsPlugin crashlytics) =>
      _crashlytics = crashlytics;

  @override
  NotificationPlugin get notification => _notification;
  set notification(final NotificationPlugin notification) =>
      _notification = notification;
}

class MockAnalyticsPlugin extends Mock implements AnalyticsPlugin {}

class MockDependencyInjectionPlugin extends Mock
    implements DependencyInjectionPlugin {}

class MockStoragePlugin extends Mock implements StoragePlugin {}

class MockNetworkPlugin extends Mock implements NetworkPlugin {}

class MockCrashlyticsPlugin extends Mock implements CrashlyticsPlugin {}

class MockSharedPreferencePlugin extends Mock
    implements SharedPreferencePlugin {}

class MockAuthHttpNetworkPlugin extends Mock implements AuthHttpNetworkPlugin {}

class MockNotificationPlugin extends Mock implements NotificationPlugin {}

class MockUserLocationProvider extends Mock with UserLocationProvider {}

class MockUniqueDeviceIdProvider extends Mock
    implements UniqueDeviceIdProvider {}

class MockDeviceInfoProvider extends Mock implements DeviceInformationPlugin {}

class MockSimSlotInfoProvider extends Mock implements SimSlotInfoProvider {}

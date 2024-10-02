import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tcs_dff_device_feature/location/location_details.dart';
import 'package:tcs_dff_device_feature/sms_feature/sim_detail.dart';
import 'package:tcs_dff_network/cache_manager.dart';
import 'package:tcs_dff_network/http_auth_network.dart';
import 'package:tcs_dff_network/http_network_configuration.dart';
import 'package:tcs_dff_network/http_network_constants.dart';
import 'package:tcs_dff_storage/cache/cache.dart';
import 'package:tcs_dff_storage/cache/cache_policy.dart';
import 'package:tcs_dff_storage/cache/cache_utils.dart';
import 'package:tcs_dff_test/dff_mocks.dart';
import 'package:tcs_dff_types/config.dart';
import 'package:tcs_dff_types/plugin/device_info_plugin.dart';
import 'package:tcs_dff_types/tcs_dff_types.dart';

class DefaultNetworkConfigurationTest {
  static HTTPNetworkConfiguration networkConfiguration =
      HTTPNetworkConfiguration(
    refreshTokenURL: '',
    rsaPublicKey: '',
    defaultHeaders: {
      'Content-Type': 'application/json; charset=UTF-8',
    },
    sessionTokenUrl: '',
  );
}

class MockCache extends Mock implements Cache {}

class FakeApiConfig extends Fake implements ApiConfig {}

class FakeBaseRequest extends Fake implements BaseRequest {}

class MockHttpClient extends Mock implements http.Client {}

class FakeUri extends Fake implements Uri {}

class MockIOException implements IOException {
  @override
  String toString() => 'MockIOException';
}

void main() {
  late Uri url;
  late CacheManager cacheManager;
  late MockUserLocationProvider mockLocationProvider;
  late MockUniqueDeviceIdProvider mockDeviceIdProvider;
  late MockDeviceInfoProvider mockDeviceInfoProvider;
  late MockSimSlotInfoProvider mockSimSlotInfoProvider;
  late AuthHttpNetworkPlugin authHttpNetworkPlugin;
  late MockCache mockCache;
  late MockClient mockClient;
  late MockHttpClient mockHttpClient;

  final locationData = LocationDetails(
    latitude: 1.2,
    longitude: 2.1,
    country: 'in',
    city: 'mum',
    state: 'Mah',
    areaCode: '123',
  );
  const deviceId = 'abc123';
  final osInfo = DeviceBasicInfo(
    os: 'Android',
    version: '10.0',
    sdkVersion: '',
    manufacturer: '',
    model: '',
  );
  final simSlotData = [SIMDetail(simSlotIndex: '1', subscriptionID: '')];

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    mockLocationProvider = MockUserLocationProvider();
    mockDeviceIdProvider = MockUniqueDeviceIdProvider();
    mockDeviceInfoProvider = MockDeviceInfoProvider();
    mockSimSlotInfoProvider = MockSimSlotInfoProvider();
    url = Uri.parse('http://www.example.com');
    cacheManager = CacheManager(
      locationProvider: mockLocationProvider,
      uniqueDeviceIdProvider: mockDeviceIdProvider,
      deviceInfoProvider: mockDeviceInfoProvider,
      simSlotInfoProvider: mockSimSlotInfoProvider,
    );
    mockCache = MockCache();
    dff = MockDffPlatform();
    mockHttpClient = MockHttpClient();
    mockClient = MockClient(
      (final request) async => http.Response(
        json.encode({'key': 'value'}),
        200,
        headers: {'authorization': 'sessiontoken'},
      ),
    );
    authHttpNetworkPlugin = AuthHttpNetworkPlugin(
      cache: mockCache,
      client: mockClient,
      networkConfiguration:
          DefaultNetworkConfigurationTest.networkConfiguration,
    )..cacheManager = cacheManager;
    when(() => mockLocationProvider.getUserLocation())
        .thenAnswer((final _) async => locationData);
    when(() => mockDeviceIdProvider.getUniqueDeviceId())
        .thenAnswer((final _) async => deviceId);
    when(() => mockDeviceInfoProvider.getOsVersion())
        .thenAnswer((final _) async => osInfo);
    when(() => mockSimSlotInfoProvider.getSIMInformation())
        .thenAnswer((final _) async => simSlotData);

    registerFallbackValue(FakeUri());
  });

  setUp(
    () => {
      when(
        () => mockCache.getSecuredItem(
          key: HttpNetworkConstants.authTokenKey,
        ),
      ).thenAnswer((final _) async => 'token'),
    },
  );

  group('network internal function test', () {
    test('get data from cache', () async {
      when(
        () => mockCache.getItem(
          key: '',
        ),
      ).thenAnswer((final _) async => 'cachedata');
      final result = await authHttpNetworkPlugin.getDataFromCache(
        ApiConfig(
          url: Uri.parse('uri'),
          cachePolicy: const CachePolicy(
            storageKey: '',
            policy: Policy.cacheOnly,
          ),
        ),
      );
      expect(result, 'cachedata');
    });
  });

  group('auth plugin http method test', () {
    test('API request GET with auth token', () async {
      final apiConfig = ApiConfig(url: url);

      final response = await authHttpNetworkPlugin.get(apiConfig: apiConfig);
      expect(response.statusCode, 200);
      expect(response.body, isNotEmpty);
    });

    test('API request GET with session token', () async {
      final apiConfig = ApiConfig(url: url);

      when(
        () => mockCache.getSecuredItem(
          key: HttpNetworkConstants.sessionTokenCollectionKey,
        ),
      ).thenAnswer((final _) async => null);
      final response = await authHttpNetworkPlugin.get(apiConfig: apiConfig);
      expect(response.statusCode, 200);
      expect(response.body, isNotEmpty);
    });

    test('API request POST', () async {
      final apiConfig = ApiConfig(url: url, body: '');

      final response = await authHttpNetworkPlugin.post(apiConfig: apiConfig);
      expect(response.statusCode, 200);
      expect(response.body, isNotEmpty);
    });
    test('API request PUT', () async {
      final apiConfig = ApiConfig(url: url, body: '');

      final response = await authHttpNetworkPlugin.put(apiConfig: apiConfig);
      expect(response.statusCode, 200);
      expect(response.body, isNotEmpty);
    });

    test('API request DELETE', () async {
      final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
      final apiConfig = ApiConfig(url: url, headers: headers);

      final response = await authHttpNetworkPlugin.delete(apiConfig: apiConfig);

      expect(response.statusCode, 200);
      expect(response.body, isNotEmpty);
    });
    test('API request HEAD', () async {
      final config = ApiConfig(url: url, body: '');
      final response = await authHttpNetworkPlugin.head(apiConfig: config);

      expect(response.statusCode, 200);
      expect(response.body, isNotEmpty);
    });
    test('API request PATCH', () async {
      final config = ApiConfig(
        url: url,
      );
      final response = await authHttpNetworkPlugin.patch(apiConfig: config);

      expect(response.statusCode, 200);
      expect(response.body, isNotEmpty);
    });

    test('API request read', () async {
      final config = ApiConfig(
        url: url,
      );
      final response = await authHttpNetworkPlugin.read(apiConfig: config);
      expect(response, isNotEmpty);
    });
    test('API request read bytes', () async {
      final config = ApiConfig(
        url: url,
      );
      final response = await authHttpNetworkPlugin.readBytes(apiConfig: config);
      expect(response, isNotEmpty);
    });
  });

  group('retry and timeout', () {
    test('execute request with retry', () async {
      final apiConfig = ApiConfig(url: url, retry: 1);

      authHttpNetworkPlugin.setHttpClient(mockHttpClient);

      Future<http.Response> mockRequest() =>
          mockHttpClient.get(Uri.parse('https://example.com'));

      when(mockRequest)
          .thenAnswer((final _) async => http.Response('Error', 500));

      try {
        await authHttpNetworkPlugin.executeRequest(
          mockRequest,
          retry: apiConfig.retry,
        );
      } on NetworkException catch (_) {
        expect(_.type, ExceptionType.unknown);
      } catch (e) {
        fail('Unexpected exception: $e');
      }

      verify(
        mockRequest,
      ).called(apiConfig.retry + 1);
    });

    test(
      'timeout throws exception with type timeout',
      () async {
        final apiConfig =
            ApiConfig(url: url, timeOut: const Duration(milliseconds: 100));

        authHttpNetworkPlugin.setHttpClient(mockHttpClient);

        Future<http.Response> mockRequest() =>
            mockHttpClient.get(Uri.parse('https://example.com'));

        when(mockRequest).thenAnswer(
          (final _) async => Future.delayed(
            const Duration(milliseconds: 200),
            () => http.Response(
              json.encode({'key': 'value'}),
              500,
            ),
          ),
        );

        expect(
          () async => await authHttpNetworkPlugin.executeRequest(
            mockRequest,
            retry: 3,
            timeOut: apiConfig.timeOut,
          ),
          throwsA(isA<NetworkException>()),
        );

        verify(mockRequest).called(1);
      },
    );
  });
  group('auth plugin function test', () {
    setUp(() {
      mockClient = MockClient(
        (final request) async => http.Response(
          json.encode({'key': 'value'}),
          200,
          headers: {'authorization': 'sessiontoken'},
        ),
      );
      authHttpNetworkPlugin = AuthHttpNetworkPlugin(
        cache: mockCache,
        client: mockClient,
        networkConfiguration:
            DefaultNetworkConfigurationTest.networkConfiguration,
      )..cacheManager = cacheManager;
    });

    test('login successful', () async {
      final apiConfig = ApiConfig(url: url, body: '');
      when(
        () => mockCache.setSecuredItem(
          key: any(named: 'key'),
          data: any(named: 'data'),
        ),
      ).thenAnswer((final _) async {});
      final response = await authHttpNetworkPlugin.login(apiConfig: apiConfig);
      expect(response.statusCode, 200);
      expect(response.body, isNotEmpty);
    });

    test('login throws network exception', () async {
      final apiConfig = ApiConfig(url: url, body: '');
      mockClient = MockClient(
        (final request) async => http.Response(
          json.encode({'key': 'value1'}),
          200,
          headers: {'no': 'value'},
        ),
      );
      try {
        await authHttpNetworkPlugin.login(apiConfig: apiConfig);
      } on NetworkException catch (_) {
        expect(_.type, ExceptionType.unknown);
      } catch (e) {
        fail('Unexpected exception: $e');
      }
    });

    test('logout successful', () async {
      final apiConfig = ApiConfig(url: url, body: '');

      final response = await authHttpNetworkPlugin.logout(apiConfig: apiConfig);
      expect(response.statusCode, 200);
      expect(response.body, isNotEmpty);
    });

    test('isloggedin true', () async {
      final result = await authHttpNetworkPlugin.isloggedIn();
      expect(result, true);
    });

    test('isloggedin false', () async {
      when(
        () => mockCache.getSecuredItem(
          key: HttpNetworkConstants.authTokenKey,
        ),
      ).thenAnswer((final _) async => null);
      final result = await authHttpNetworkPlugin.isloggedIn();
      expect(result, false);
    });

    test('initiate session successful', () async {
      final apiConfig = ApiConfig(url: url, body: '');
      when(
        () => mockCache.setSecuredItem(
          key: any(named: 'key'),
          data: any(named: 'data'),
        ),
      ).thenAnswer((final _) async {});
      final response =
          await authHttpNetworkPlugin.initiateSession(apiConfig: apiConfig);
      expect(response.statusCode, 200);
      expect(response.headers, isNotEmpty);
    });

    test('retreive auth headers when not login', () async {
      when(
        () => mockCache.getSecuredItem(
          key: HttpNetworkConstants.authTokenKey,
        ),
      ).thenAnswer((final _) async => null);
      when(
        () => mockCache.getSecuredItem(
          key: HttpNetworkConstants.sessionTokenCollectionKey,
        ),
      ).thenAnswer((final _) async => null);
      when(
        () => mockCache.setSecuredItem(
          key: any(named: 'key'),
          data: any(named: 'data'),
        ),
      ).thenAnswer((final _) async {});
      await authHttpNetworkPlugin.retriveAuthHeaders();
      verify(
        () => mockCache.getSecuredItem(
          key: HttpNetworkConstants.sessionTokenCollectionKey,
        ),
      ).called(2);
    });
  });

  group('Exception test', () {
    setUpAll(() => authHttpNetworkPlugin.setHttpClient(mockHttpClient));
    test('API request GET with IO Exception', () async {
      final config = ApiConfig(url: url);
      when(
        () => mockHttpClient.get(any(), headers: any(named: 'headers')),
      ).thenThrow(MockIOException());
      try {
        await authHttpNetworkPlugin.get(apiConfig: config);
      } on NetworkException catch (_) {
        expect(_.type, ExceptionType.ioexception);
      } catch (e) {
        fail('Unexpected exception: $e');
      }
    });

    test('API request GET with Socket Exception', () async {
      final config = ApiConfig(url: url);
      when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
          .thenThrow(const SocketException('socket exception'));
      try {
        await authHttpNetworkPlugin.get(apiConfig: config);
      } on NetworkException catch (_) {
        expect(_.type, ExceptionType.socket);
      } catch (e) {
        fail('Unexpected exception: $e');
      }
    });

    test('API request GET with Timeout Exception', () async {
      final config = ApiConfig(url: url);
      when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
          .thenThrow(TimeoutException('timeout'));
      try {
        await authHttpNetworkPlugin.get(apiConfig: config);
      } on NetworkException catch (_) {
        expect(_.type, ExceptionType.timeout);
      } catch (e) {
        fail('Unexpected exception: $e');
      }
    });

    test('API request GET with Auth Exception', () async {
      final config = ApiConfig(url: url);
      when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
          .thenThrow(
        AuthorizationException(error: Error(title: '', description: '')),
      );
      try {
        await authHttpNetworkPlugin.get(apiConfig: config);
      } on NetworkException catch (_) {
        expect(_.type, ExceptionType.authorization);
      } catch (e) {
        fail('Unexpected exception: $e');
      }
    });

    test('API request GET with Unknown Exception', () async {
      final config = ApiConfig(url: url);
      when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
          .thenThrow(Exception());
      try {
        await authHttpNetworkPlugin.get(apiConfig: config);
      } on NetworkException catch (_) {
        expect(_.type, ExceptionType.unknown);
      } catch (e) {
        fail('Unexpected exception: $e');
      }
    });
  });
}

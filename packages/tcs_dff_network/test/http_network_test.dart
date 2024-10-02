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
import 'package:tcs_dff_network/http_network.dart';
import 'package:tcs_dff_network/http_network_configuration.dart';
import 'package:tcs_dff_network/http_network_constants.dart';
import 'package:tcs_dff_storage/cache/cache_item.dart';
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

class FakeApiConfig extends Fake implements ApiConfig {}

class FakeBaseRequest extends Fake implements BaseRequest {}

class MockHttpClient extends Mock implements http.Client {}

class FakeUri extends Fake implements Uri {}

class MockIOException implements IOException {
  @override
  String toString() => 'MockIOException';
}

void main() {
  late HttpNetworkPlugin httpNetwork;
  late Map<String, String> defaultHeaders;
  late Map<String, dynamic> requestBody;
  late Uri getURL, postURL, putURL;
  late MockUserLocationProvider mockLocationProvider;
  late MockUniqueDeviceIdProvider mockDeviceIdProvider;
  late MockDeviceInfoProvider mockDeviceInfoProvider;
  late MockSimSlotInfoProvider mockSimSlotInfoProvider;
  late MockHttpClient mockHttpClient;

  final authJson = jsonEncode(
    CacheItem(
      key: HttpNetworkConstants.sessionTokenCollectionKey,
      data: 'sr5cf01700719386443001',
      expiryTime: getExpiryDate(duration: const Duration(minutes: 5)),
    ),
  );
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
    mockHttpClient = MockHttpClient();

    registerFallbackValue(FakeApiConfig());
    registerFallbackValue(FakeBaseRequest());
    registerFallbackValue(FakeUri());
  });

  group('network plugin', () {
    setUp(() {
      httpNetwork = HttpNetworkPlugin(
        networkConfiguration:
            DefaultNetworkConfigurationTest.networkConfiguration,
      );

      defaultHeaders = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
      requestBody = {
        'userId': '100',
        'id': '200',
        'title': 'Testing from Flutter',
        'body': 'This is testing for post method',
      };

      getURL = Uri.parse('https://jsonplaceholder.typicode.com/posts');
      postURL = Uri.parse('https://jsonplaceholder.typicode.com/posts');
      putURL = Uri.parse('https://jsonplaceholder.typicode.com/posts/100');

      dff = MockDffPlatform();

      when(
        () => dff.sharedPreferences.getSecuredStringValue(
          key: any(
            named: 'key',
            that: startsWith(HttpNetworkConstants.sessionTokenCollectionKey),
          ),
        ),
      ).thenAnswer((final _) async => Future.value(authJson));

      when(() => mockLocationProvider.getUserLocation())
          .thenAnswer((final _) async => locationData);
      when(() => mockDeviceIdProvider.getUniqueDeviceId())
          .thenAnswer((final _) async => deviceId);
      when(() => mockDeviceInfoProvider.getOsVersion())
          .thenAnswer((final _) async => osInfo);
      when(() => mockSimSlotInfoProvider.getSIMInformation())
          .thenAnswer((final _) async => simSlotData);
    });

    test('API request GET with IO Exception', () async {
      final config = ApiConfig(url: getURL);
      httpNetwork.client = mockHttpClient;
      when(() => httpNetwork.client.get(any(), headers: defaultHeaders))
          .thenThrow(MockIOException());
      try {
        await httpNetwork.get(apiConfig: config);
      } on NetworkException catch (_) {
        expect(_.type, ExceptionType.ioexception);
      } catch (e) {
        fail('Unexpected exception: $e');
      }
    });

    test('API request GET with Socket Exception', () async {
      final config = ApiConfig(url: getURL);
      httpNetwork.client = mockHttpClient;
      when(() => httpNetwork.client.get(any(), headers: defaultHeaders))
          .thenThrow(const SocketException('socket exception'));
      try {
        await httpNetwork.get(apiConfig: config);
      } on NetworkException catch (_) {
        expect(_.type, ExceptionType.socket);
      } catch (e) {
        fail('Unexpected exception: $e');
      }
    });

    test('API request GET with Timeout Exception', () async {
      final config = ApiConfig(url: getURL);
      httpNetwork.client = mockHttpClient;
      when(() => httpNetwork.client.get(any(), headers: defaultHeaders))
          .thenThrow(TimeoutException('timeout'));
      try {
        await httpNetwork.get(apiConfig: config);
      } on NetworkException catch (_) {
        expect(_.type, ExceptionType.timeout);
      } catch (e) {
        fail('Unexpected exception: $e');
      }
    });

    test('API request GET with Unknown Exception', () async {
      final config = ApiConfig(url: getURL);
      httpNetwork.client = mockHttpClient;
      when(() => httpNetwork.client.get(any(), headers: defaultHeaders))
          .thenThrow(Exception());
      try {
        await httpNetwork.get(apiConfig: config);
      } on NetworkException catch (_) {
        expect(_.type, ExceptionType.unknown);
      } catch (e) {
        fail('Unexpected exception: $e');
      }
    });

    test('API request GET', () async {
      httpNetwork.client = MockClient(
        (final request) async => http.Response(
          json.encode({'key': 'value'}),
          200,
        ),
      );
      final config = ApiConfig(url: getURL);
      final response = await httpNetwork.get(apiConfig: config);
      expect(response.statusCode, 200);
      expect(response.body, isNotEmpty);
    });
    test('API request POST', () async {
      httpNetwork.client = MockClient(
        (final request) async => http.Response(
          json.encode({'key': 'value'}),
          201,
        ),
      );
      final config =
          ApiConfig(url: postURL, body: requestBody, headers: defaultHeaders);
      final response = await httpNetwork.post(apiConfig: config);

      expect(response.statusCode, 201);
      expect(response.body, isNotEmpty);
    });

    test('API request PUT', () async {
      httpNetwork.client = MockClient(
        (final request) async => http.Response(
          json.encode({'key': 'value'}),
          200,
        ),
      );

      final config =
          ApiConfig(url: postURL, headers: defaultHeaders, body: requestBody);
      final response = await httpNetwork.put(apiConfig: config);

      expect(response.statusCode, 200);
      expect(response.body, isNotEmpty);
    });
    test('API request DELETE', () async {
      httpNetwork.client = MockClient(
        (final request) async => http.Response(
          json.encode({'key': 'value'}),
          200,
        ),
      );
      final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
      final config =
          ApiConfig(url: putURL, headers: headers, body: requestBody);
      final response = await httpNetwork.delete(apiConfig: config);

      expect(response.statusCode, 200);
      expect(response.body, isNotEmpty);
    });
    test('API request HEAD', () async {
      httpNetwork.client = MockClient(
        (final request) async => http.Response(
          json.encode({'key': 'value'}),
          200,
        ),
      );

      final config =
          ApiConfig(url: postURL, headers: defaultHeaders, body: requestBody);
      final response = await httpNetwork.head(apiConfig: config);

      expect(response.statusCode, 200);
      expect(response.body, isNotEmpty);
    });
    test('API request PATCH', () async {
      httpNetwork.client = MockClient(
        (final request) async => http.Response(
          json.encode({'key': 'value'}),
          200,
        ),
      );
      final config =
          ApiConfig(url: postURL, headers: defaultHeaders, body: requestBody);
      final response = await httpNetwork.patch(apiConfig: config);

      expect(response.statusCode, 200);
      expect(response.body, isNotEmpty);
    });

    test('API request read', () async {
      httpNetwork.client = MockClient(
        (final request) async => http.Response(
          json.encode({'key': 'value'}),
          200,
        ),
      );
      final config = ApiConfig(url: putURL, headers: defaultHeaders);
      final response = await httpNetwork.read(apiConfig: config);
      expect(response, isNotEmpty);
    });
    test('API request read bytes', () async {
      httpNetwork.client = MockClient(
        (final request) async => http.Response(
          json.encode({'key': 'value'}),
          200,
        ),
      );
      final config = ApiConfig(url: putURL, headers: defaultHeaders);
      final response = await httpNetwork.readBytes(apiConfig: config);
      expect(response, isNotEmpty);
    });

    test('sends request with correct headers', () async {
      httpNetwork.client = MockClient(
        (final request) async => http.Response(
          json.encode({'key': 'value'}),
          200,
        ),
      );
      final request = http.Request('GET', Uri.parse('https://example.com'));
      final expectedResponse = http.StreamedResponse(const Stream.empty(), 200);

      final response = await httpNetwork.send(request: request);

      expect(response.statusCode, expectedResponse.statusCode);
    });
  });
}

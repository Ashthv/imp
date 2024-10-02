import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tcs_dff_device_feature/device_info/device_info.dart';
import 'package:tcs_dff_storage/cache/cache.dart';
import 'package:tcs_dff_types/plugin/device_info_plugin.dart';

class MockDeviceInfoPlugin extends Mock implements DeviceInfoPlugin {}

class MockCache extends Mock implements Cache {
  @override
  Future<void> setItem({
    required final String key,
    required final String data,
    final Duration? expiryTime,
  }) async =>
      Future.value();
}

class FakeAndroidDeviceInfo extends Fake implements AndroidDeviceInfo {}

class FakeUTSName extends Fake implements IosUtsname {
  @override
  String get machine => 'iPhone14';
}

class FakeiOSDeviceInfo extends Fake implements IosDeviceInfo {
  @override
  String get systemName => 'iOS';
  @override
  String get systemVersion => '16.0';
  @override
  IosUtsname get utsname => FakeUTSName();
  @override
  String get name => 'Apple Inc.';
}

/// There are 2 approach shown for test cases
/// 1. With fake object
/// 2. Create an actual object with values expected from device api
void main() {
  setUpAll(() => registerFallbackValue(FakeAndroidDeviceInfo()));

  group('DeviceInformationPlugin', () {
    late DeviceInformationPlugin deviceInfoPlugin;
    late MockDeviceInfoPlugin mockDeviceInfoPlugin;
    late MockCache mockCache;

    setUp(() {
      mockDeviceInfoPlugin = MockDeviceInfoPlugin();
      mockCache = MockCache();
      deviceInfoPlugin = DeviceInfo()
        ..cache = mockCache
        ..deviceInfoPlugin = mockDeviceInfoPlugin
        ..deviceInfoCacheKey = 'deviceInfoKey';
    });
    group('getOsVersion', () {
      test('returns IOS details on test platform', () async {
        final cachedData = DeviceBasicInfo(
          os: 'iOS',
          version: '16.0',
          sdkVersion: 'NA',
          model: 'iPhone14,2',
          manufacturer: 'Apple Inc.',
        );
        debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
        when(() => mockCache.getItem(key: 'deviceInfoKey'))
            .thenAnswer((final _) async => jsonEncode(cachedData.toJson()));

        final result = await deviceInfoPlugin.getOsVersion();

        expect(result, isNotNull);
        expect(result!.os, 'iOS');
      });

      test('returns Android details on test platform', () async {
        final cachedData = DeviceBasicInfo(
          os: 'Android',
          version: '14.0',
          sdkVersion: 'NA',
          model: 'Android',
          manufacturer: 'Google Inc.',
        );
        debugDefaultTargetPlatformOverride = TargetPlatform.android;
        when(() => mockCache.getItem(key: 'deviceInfoKey'))
            .thenAnswer((final _) async => jsonEncode(cachedData.toJson()));

        final result = await deviceInfoPlugin.getOsVersion();
        expect(result, isNotNull);
        expect(result!.os, 'Android');
      });
    });
    group('getIosOsDetails', () {
      test('returns cached data if available', () async {
        final cachedData = DeviceBasicInfo(
          os: 'iOS',
          version: '16.0',
          sdkVersion: 'NA',
          model: 'iPhone14,2',
          manufacturer: 'Apple Inc.',
        );
        when(() => mockCache.getItem(key: 'deviceInfoKey'))
            .thenAnswer((final _) async => jsonEncode(cachedData.toJson()));

        final result = await deviceInfoPlugin.getIosOsDetails();

        expect(result.os, cachedData.os);
        expect(result.version, cachedData.version);
      });

      test('fetches data from plugin and caches it when cache is empty',
          () async {
        final iosInfo = FakeiOSDeviceInfo();
        when(() => mockCache.getItem(key: 'deviceInfoKey'))
            .thenAnswer((final _) async => null);

        when(() => mockDeviceInfoPlugin.iosInfo)
            .thenAnswer((final _) async => iosInfo);

        final result = await deviceInfoPlugin.getIosOsDetails();

        expect(result, isNotNull);
        expect(result.os, equals('iOS'));
        expect(result.version, equals('16.0'));
        expect(result.sdkVersion, equals('NA'));
        expect(result.model, equals('iPhone14'));
        expect(result.manufacturer, equals('Apple Inc.'));
      });
    });
    group('getAndroidOsDetails', () {
      test('returns cached data if available', () async {
        final cachedData = DeviceBasicInfo(
          os: 'Android',
          version: '12.0',
          sdkVersion: '31',
          model: 'Pixel 6',
          manufacturer: 'Google',
        );
        when(() => mockCache.getItem(key: 'deviceInfoKey'))
            .thenAnswer((final _) async => jsonEncode(cachedData.toJson()));

        final result = await deviceInfoPlugin.getAndroidOsDetails();

        expect(result.os, cachedData.os);
        expect(result.version, cachedData.version);
      });

      test('fetches data from plugin and caches it when cache is empty',
          () async {
        final androidInfo = AndroidDeviceInfo.fromMap({
          'version': {
            'baseOS': 'baseOS_value',
            'codename': 'codename_value',
            'incremental': 'incremental_value',
            'previewSdkInt': 123,
            'release': '12.0',
            'sdkInt': 31,
            'securityPatch': 'securityPatch_value',
          },
          'board': 'board_value',
          'bootloader': 'bootloader_value',
          'brand': 'brand_value',
          'device': 'device_value',
          'display': 'display_value',
          'fingerprint': 'fingerprint_value',
          'hardware': 'hardware_value',
          'host': 'host_value',
          'id': 'id_value',
          'manufacturer': 'Google',
          'model': 'Pixel 6',
          'product': 'product_value',
          'supported32BitAbis': ['abi1', 'abi2'],
          'supported64BitAbis': ['abi3', 'abi4'],
          'supportedAbis': ['abi5', 'abi6'],
          'tags': 'tags_value',
          'type': 'type_value',
          'isPhysicalDevice': true,
          'systemFeatures': ['feature1', 'feature2'],
          'displayMetrics': {
            'xDpi': 420.0,
            'yDpi': 420.0,
            'widthPx': 1080.0,
            'heightPx': 1920.0,
          },
          'serialNumber': 'serial_number_value',
        });
        when(() => mockCache.getItem(key: 'deviceInfoKey'))
            .thenAnswer((final _) async => null);

        when(() => mockDeviceInfoPlugin.androidInfo)
            .thenAnswer((final _) async => androidInfo);

        final result = await deviceInfoPlugin.getAndroidOsDetails();

        expect(result, isNotNull);
        expect(result.os, equals('Android'));
        expect(result.version, equals('12.0'));
        expect(result.sdkVersion, equals('31'));
        expect(result.model, equals('Pixel 6'));
        expect(result.manufacturer, equals('Google'));
      });

      test('handles exceptions from device info plugin', () async {
        when(() => mockCache.getItem(key: 'deviceInfoKey'))
            .thenAnswer((final _) async => null);
        when(() => mockDeviceInfoPlugin.androidInfo)
            .thenThrow(Exception('Failed to get device info'));

        expect(
          () async => await deviceInfoPlugin.getAndroidOsDetails(),
          throwsException,
        );
      });
    });
  });
}

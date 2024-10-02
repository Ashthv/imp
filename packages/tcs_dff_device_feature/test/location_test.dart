import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tcs_dff_device_feature/location/location_details.dart';
import 'package:tcs_dff_device_feature/location/user_location.dart';
import 'package:tcs_dff_device_feature/permission/device_permission_manager.dart';
import 'package:tcs_dff_device_feature/permission/permission_types.dart';
import 'package:tcs_dff_storage/cache/cache.dart';
import 'package:tcs_dff_types/exceptions.dart';

class MockDevicePermissionManager extends Mock
    implements DevicePermissionManager {}

class MockCache extends Mock implements Cache {
  @override
  Future<void> setItem({
    required final String key,
    required final String data,
    final Duration? expiryTime,
  }) async =>
      Future.value();
}

class MockGeolocator extends Mock implements Geolocator {}

class MockGeolocatorWrapper extends Mock implements GeoLocatorWrapper {}

class MockGeocodingPlatform extends GeocodingPlatform {}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  late MockDevicePermissionManager mockDevicePermissionManager;
  late UserLocationProvider userLocationProvider;
  late MockCache mockCache;
  late MockGeocodingPlatform mockGeocodingPlatform;
  late MockGeolocatorWrapper mockGeolocatorWrapper;

  setUp(() {
    mockDevicePermissionManager = MockDevicePermissionManager();
    mockCache = MockCache();
    mockGeolocatorWrapper = MockGeolocatorWrapper();
    userLocationProvider =
        UserLocation(geoLocatorWrapper: mockGeolocatorWrapper)
          ..cache = mockCache
          ..devicePermissionManager = mockDevicePermissionManager;
    mockGeocodingPlatform = MockGeocodingPlatform();

    GeocodingPlatform.instance = mockGeocodingPlatform;
  });
  group('getUserLocation', () {
    test('returns cached data if available', () async {
      final cachedData = LocationDetails(
        latitude: 37.7749,
        longitude: -122.4194,
        country: 'india',
        state: 'mh',
        city: 'mum',
        areaCode: '123456',
      );
      when(() => mockCache.getItem(key: 'locationDetailsKey'))
          .thenAnswer((final _) async => jsonEncode(cachedData.toJson()));

      final result = await userLocationProvider.getUserLocation();

      expect(result!.areaCode, cachedData.areaCode);
      expect(result.latitude, cachedData.latitude);
    });

    test('fetches location when cache is empty and permission is granted',
        () async {
      when(() => mockCache.getItem(key: 'locationDetailsKey'))
          .thenAnswer((final _) async => null);
      when(
        () => mockDevicePermissionManager
            .checkAndRequestPermission(DevicePermission.location),
      ).thenAnswer((final _) async => DevicePermissionStatus.granted);
      final position = Position(
        longitude: -122.4194,
        latitude: 37.7749,
        timestamp: DateTime.now(),
        accuracy: 10.0,
        altitude: 50.0,
        heading: 0.0,
        speed: 0.0,
        speedAccuracy: 0.0,
        altitudeAccuracy: 1.0,
        headingAccuracy: 1.0,
      );
      when(
        () => mockGeolocatorWrapper.getCurrentPosition(),
      ).thenAnswer((final _) async => position);
      when(
        () => mockGeolocatorWrapper.placemarkFromCoordinates(
          any(),
          any(),
        ),
      ).thenAnswer(
        (final _) async => [
          const Placemark(
            country: 'india',
            administrativeArea: 'mh',
            locality: 'mum',
            postalCode: '123456',
          ),
        ],
      );

      final result = await userLocationProvider.getUserLocation();

      expect(result, isNotNull);
      expect(result!.latitude, equals(37.7749));
      expect(result.longitude, equals(-122.4194));
      expect(result.country, equals('india'));
      expect(result.state, equals('mh'));
      expect(result.city, equals('mum'));
      expect(result.areaCode, equals('123456'));
    });

    test('throws exception when permission is denied', () async {
      when(() => mockCache.getItem(key: 'locationDetailsKey'))
          .thenAnswer((final _) async => null);
      when(
        () => mockDevicePermissionManager
            .checkAndRequestPermission(DevicePermission.location),
      ).thenAnswer((final _) async => DevicePermissionStatus.denied);

      expect(
        () async => await userLocationProvider.getUserLocation(),
        throwsA(isA<DevicePermissionException>()),
      );
    });
  });

  group('openLocationSettings', () {
    test('location settings opened successfully', () async {
      when(
        () => mockGeolocatorWrapper.openLocationSettings(),
      ).thenAnswer((final _) async => true);

      final value = await userLocationProvider.openLocationSettings();

      expect(value, true);
    });

    test('location settings failed to open', () async {
      when(
        () => mockGeolocatorWrapper.openLocationSettings(),
      ).thenAnswer((final _) async => false);

      final value = await userLocationProvider.openLocationSettings();

      expect(value, false);
    });
  });

  group('getLocationServiceStatusStream', () {
    test('location service is enabled', () async {
      when(
        () => mockGeolocatorWrapper.getServiceStatusStream(),
      ).thenAnswer((final _) async* {
        yield LocationServiceStatus.enabled;
      });

      userLocationProvider
          .getLocationServiceStatusStream()
          .listen((final serviceStatus) {
        expect(
          serviceStatus,
          LocationServiceStatus.enabled,
        );
      });
    });

    test('location service is disabled', () async {
      when(
        () => mockGeolocatorWrapper.getServiceStatusStream(),
      ).thenAnswer((final _) async* {
        yield LocationServiceStatus.disabled;
      });

      userLocationProvider
          .getLocationServiceStatusStream()
          .listen((final serviceStatus) {
        expect(
          serviceStatus,
          LocationServiceStatus.disabled,
        );
      });
    });
  });
}

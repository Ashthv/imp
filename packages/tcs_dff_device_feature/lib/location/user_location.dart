import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart' hide ServiceStatus;
import 'package:tcs_dff_storage/cache/cache.dart';
import 'package:tcs_dff_storage/cache/cache_utils.dart';
import 'package:tcs_dff_types/exceptions.dart';

import '../location/location_details.dart';
import '../permission/device_permission_manager.dart';
import '../permission/permission_types.dart';
import '../utils/string_constants.dart';

typedef LocationServiceStatus = ServiceStatus;

mixin UserLocationProvider {
  Future<LocationDetails?> getUserLocation();
  Future<bool> openLocationSettings();
  Stream<LocationServiceStatus> getLocationServiceStatusStream();
}

class UserLocation implements UserLocationProvider {
  late Position _currentPosition;
  late DevicePermissionManager devicePermissionManager;
  late GeoLocatorWrapper geoLocatorWrapper;
  UserLocation({this.geoLocatorWrapper = const GeoLocatorWrapper()}) {
    devicePermissionManager = DevicePermissionManager();
  }
  Cache cache = Cache();

  final String locationCacheKey = 'locationDetailsKey';

  final cacheDuration = getExpiryDate(duration: const Duration(minutes: 5));

  @visibleForTesting
  Future<LocationDetails?> getDataFromCache() async {
    final data = await cache.getItem(
      key: locationCacheKey,
    );
    return data != null
        ? LocationDetails.fromJson(jsonDecode(data) as Map<String, dynamic>)
        : null;
  }

  Future<void> _storeLocation(final LocationDetails locationInfo) async {
    await cache.setItem(
      key: locationCacheKey,
      data: jsonEncode(locationInfo.toJson()),
      expiryTime: cacheDuration,
    );
  }

  Future<LocationDetails> _getLocation() async {
    _currentPosition = await geoLocatorWrapper.getCurrentPosition();
    final locationInfo = LocationDetails(
      latitude: _currentPosition.latitude,
      longitude: _currentPosition.longitude,
    );
    try {
      // We can get address from same while testing with actual device
      final placeMark = await geoLocatorWrapper.placemarkFromCoordinates(
        _currentPosition.latitude,
        _currentPosition.longitude,
      );

      final place = placeMark[0];
      locationInfo
        ..country = '${place.country}'
        ..state = '${place.administrativeArea}'
        ..city = '${place.locality}'
        ..areaCode = '${place.postalCode}';
    } catch (e) {
      // handle platform exception
      await _storeLocation(locationInfo);
      return locationInfo;
    }
    await _storeLocation(locationInfo);
    return locationInfo;
  }

  @override
  Future<LocationDetails?> getUserLocation() async {
    final cacheData = await getDataFromCache();

    if (cacheData != null) {
      return cacheData;
    }

    final status = devicePermissionManager
        .checkAndRequestPermission(DevicePermission.location);

    if (await status.isGranted) {
      final location = await _getLocation();

      return location;
    } else {
      throw DevicePermissionException(
        error: Error(
          title: permissionDenyMessage,
          description: status.toString(),
        ),
      );
    }
  }

  @override
  Future<bool> openLocationSettings() =>
      geoLocatorWrapper.openLocationSettings();

  @override
  Stream<LocationServiceStatus> getLocationServiceStatusStream() =>
      geoLocatorWrapper.getServiceStatusStream();
}

class GeoLocatorWrapper {
  const GeoLocatorWrapper();
  Future<Position> getCurrentPosition({
    final LocationAccuracy desiredAccuracy = LocationAccuracy.high,
  }) =>
      Geolocator.getCurrentPosition(
        desiredAccuracy: desiredAccuracy,
      );

  Future<List<Placemark>> placemarkFromCoordinates(
    final double latitude,
    final double longitude, {
    final String? localeIdentifier,
  }) =>
      placemarkFromCoordinates(
        latitude,
        longitude,
      );

  Future<bool> openLocationSettings() => Geolocator.openLocationSettings();

  Stream<LocationServiceStatus> getServiceStatusStream() =>
      Geolocator.getServiceStatusStream();
}

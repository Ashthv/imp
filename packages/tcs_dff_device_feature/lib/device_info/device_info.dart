import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:tcs_dff_storage/cache/cache.dart';
import 'package:tcs_dff_storage/cache/cache_utils.dart';
import 'package:tcs_dff_types/plugin/device_info_plugin.dart';

class DeviceInfo implements DeviceInformationPlugin {
  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  Cache cache = Cache();

  String deviceInfoCacheKey = 'deviceInfoKey';

  final cacheDuration = getExpiryDate(duration: const Duration(minutes: 10));

  @visibleForTesting
  Future<DeviceBasicInfo?> getDataFromCache() async {
    final data = await cache.getItem(
      key: deviceInfoCacheKey,
    );

    return data != null && data.isNotEmpty
        ? DeviceBasicInfo.fromJson(jsonDecode(data) as Map<String, dynamic>)
        : null;
  }

  @override
  Future<DeviceBasicInfo?> getOsVersion() async {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return getAndroidOsDetails();
      case TargetPlatform.iOS:
        return getIosOsDetails();
      default:
        return null;
    }
  }

  @override
  Future<DeviceBasicInfo> getAndroidOsDetails() async {
    final cacheData = await getDataFromCache();

    if (cacheData != null) {
      return cacheData;
    }

    final android = await deviceInfoPlugin.androidInfo;

    final androidDeviceInfo = DeviceBasicInfo(
      os: 'Android',
      version: android.version.release,
      sdkVersion: android.version.sdkInt.toString(),
      model: android.model,
      manufacturer: android.manufacturer,
    );

    await cache.setItem(
      key: deviceInfoCacheKey,
      data: jsonEncode(androidDeviceInfo.toJson()),
      expiryTime: cacheDuration,
    );

    return androidDeviceInfo;
  }

  @override
  Future<DeviceBasicInfo> getIosOsDetails() async {
    final cacheData = await getDataFromCache();

    if (cacheData != null) {
      return cacheData;
    }

    final ios = await deviceInfoPlugin.iosInfo;

    final iosDeviceInfo = DeviceBasicInfo(
      os: ios.systemName,
      version: ios.systemVersion,
      sdkVersion: 'NA',
      model: ios.utsname.machine,
      manufacturer: ios.name,
    );

    await cache.setItem(
      key: deviceInfoCacheKey,
      data: jsonEncode(iosDeviceInfo.toJson()),
    );

    return iosDeviceInfo;
  }
}

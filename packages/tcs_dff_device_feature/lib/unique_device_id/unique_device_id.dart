import 'package:firebase_app_installations/firebase_app_installations.dart';
import 'package:flutter/services.dart';
import 'package:tcs_dff_storage/cache/cache.dart';
import 'package:tcs_dff_storage/cache/cache_utils.dart';
import 'package:tcs_dff_types/exceptions.dart';

import '../utils/string_constants.dart';
import 'uniqueids.dart';

mixin UniqueDeviceIdProvider {
  Future<String?> getUniqueDeviceId();
}

class UniqueDeviceId implements UniqueDeviceIdProvider {
  MethodChannel deviceIdChannel = const MethodChannel('com.dff.device_feature');

  Cache cache = Cache();

  final String uuidCacheKey = 'uuidKey';

  final cacheDuration = getExpiryDate(duration: const Duration(minutes: 10));

  Future<String?> _getUuidFromCache() async => await cache.getItem(
        key: uuidCacheKey,
      );

  @override
  Future<String?> getUniqueDeviceId() async {
    try {
      return await deviceIdChannel.invokeMethod<String>(
        'getUniqueDeviceId',
      );
    } catch (e) {
      NativeException(
        error: Error(
          description: e.toString(),
          title: deviceIdExceptionTitle,
        ),
      );
    }
    return null;
  }

  Future<String?> getAndroidUUIDId() async {
    final cacheData = await _getUuidFromCache();
    String? androidUuid;

    if (cacheData != null) {
      return cacheData;
    }

    try {
      androidUuid = await deviceIdChannel.invokeMethod<String>(
        'getAndroidUUIDId',
      );

      await cache.setItem(
        key: uuidCacheKey,
        data: androidUuid.toString(),
        expiryTime: cacheDuration,
      );
    } catch (e) {
      NativeException(
        error: Error(
          description: e.toString(),
          title: deviceIdExceptionTitle,
        ),
      );
    }

    return androidUuid.toString();
  }

  Future<String?> getFid() async {
    try {
      return await FirebaseInstallations.instance.getId();
    } catch (e) {
      NativeException(
        error: Error(
          description: e.toString(),
          title: firebaseIdExceptionTitle,
        ),
      );
    }

    return null;
  }

  Future<UniqueIds> getUniqueIds() async {
    final uniqueDeviced = await getUniqueDeviceId();
    final androidUuid = await getAndroidUUIDId();
    final fid = await getFid();

    return UniqueIds(
      uniqueDeviced: uniqueDeviced!,
      androidUuid: androidUuid!,
      fid: fid,
    );
  }
}

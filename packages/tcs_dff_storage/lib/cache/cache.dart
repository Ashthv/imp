import 'dart:convert';
import 'package:tcs_dff_types/tcs_dff_types.dart';
import 'cache_item.dart';

class Cache {
  final String _collectionName = 'cache';

  Future<void> setItem({
    required final String key,
    required final String data,
    final Duration? expiryTime,
  }) async {
    await dff.storage.setItem<String>(
      collectionName: _collectionName,
      key: key,
      item: jsonEncode(CacheItem(key: key, data: data, expiryTime: expiryTime)),
    );
  }

  Future<String?> getItem({required final String key}) async {
    CacheItem? cacheItem;
    final data = await dff.storage
        .getItem<String>(collectionName: _collectionName, key: key);
    if (data != null) {
      cacheItem = CacheItem.fromJson(
        jsonDecode(data) as Map<String, dynamic>,
      );
      if (_isDataExpired(cacheItem.expiryTime)) {
        return null;
      }
      return cacheItem.data;
    }
    return data; // check for null handling
  }

  void clearCache() {
    dff.storage.clearCollection(collectionName: _collectionName);
  }

  void deleteCacheItem(final String key) {
    dff.storage.deleteItem<String>(collectionName: _collectionName, key: key);
  }

  bool _isDataExpired(final Duration? expiryTime) {
    if (expiryTime!.inMilliseconds == 0) {
      return false;
    }
    final currentTime =
        Duration(milliseconds: DateTime.now().millisecondsSinceEpoch);
    return expiryTime.compareTo(currentTime) > 0 ? false : true;
  }

  Future<void> setSecuredItem({
    required final String key,
    required final String data,
    final Duration? expiryTime,
  }) async {
    await dff.sharedPreferences.setSecuredStringValue(
      key: key,
      value: jsonEncode(
        CacheItem(key: key, data: data, expiryTime: expiryTime),
      ),
    );
  }

  Future<String?> getSecuredItem({required final String key}) async {
    CacheItem? cacheItem;
    final data = await dff.sharedPreferences.getSecuredStringValue(key: key);
    if (data != null) {
      cacheItem = CacheItem.fromJson(
        jsonDecode(data) as Map<String, dynamic>,
      );
      if (_isDataExpired(cacheItem.expiryTime)) {
        return null;
      }
      return cacheItem.data;
    }
    return data; // check for null handling
  }
}

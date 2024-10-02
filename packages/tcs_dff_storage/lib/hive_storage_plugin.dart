import 'dart:async';

import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:tcs_dff_types/plugin/storage_plugin.dart';

Future<void> _defaultHiveInit() async {
  final dir = await path.getApplicationCacheDirectory();
  Hive.init(dir.path);
}

class HiveStoragePlugin implements StoragePlugin {
  late List<int>? _securedKey;
  late Future<void> Function() _initFunction;

  HiveStoragePlugin({
    final Future<void> Function() initFunction = _defaultHiveInit,
    final List<int>? securedKey,
  }) {
    _initFunction = initFunction;
    _initFunction();
    // if (securedKey == null) {
    //   _securedKey = Hive.generateSecureKey();
    // }
    _securedKey = securedKey;
  }

  @override
  Future<void> setItem<T>({
    required final String collectionName,
    required final T item,
    required final String key,
  }) async {
    Box<T> box;
    if (Hive.isBoxOpen(collectionName)) {
      box = Hive.box<T>(collectionName);
    } else {
      box = await _openHiveBox<T>(collectionName);
    }
    unawaited(box.put(key, item));
  }

  @override
  Future<T?> getItem<T>({
    required final String collectionName,
    required final String key,
  }) async {
    Box<T> box;
    if (Hive.isBoxOpen(collectionName)) {
      box = Hive.box<T>(collectionName);
    } else {
      box = await _openHiveBox<T>(collectionName);
    }
    return box.get(key);
  }

  @override
  Future<Map<String, T?>> getAllItems<T>({
    required final String collectionName,
    required final List<String> keys,
  }) async {
    Box<T> box;
    if (Hive.isBoxOpen(collectionName)) {
      box = Hive.box<T>(collectionName);
    } else {
      box = await _openHiveBox<T>(collectionName);
    }
    final mapData = <String, T?>{};
    for (final key in keys) {
      mapData[key] = box.get(key);
    }
    return mapData;
  }

  @override
  Future<void> deleteItem<T>({
    required final String collectionName,
    required final String key,
  }) async {
    Box box;
    if (Hive.isBoxOpen(collectionName)) {
      box = Hive.box<T>(collectionName);
    } else {
      box = await _openHiveBox<T>(collectionName);
    }
    await box.delete(key);
  }

  @override
  Future<void> deleteAllItems<T>({
    required final String collectionName,
    required final List<String> keys,
  }) async {
    Box box;
    if (Hive.isBoxOpen(collectionName)) {
      box = Hive.box(collectionName);
    } else {
      box = await _openHiveBox<T>(collectionName);
    }
    await box.deleteAll(keys);
  }

  @override
  Future<int> clearCollection<T>({required final String collectionName}) async {
    Box box;
    if (Hive.isBoxOpen(collectionName)) {
      box = Hive.box<T>(collectionName);
    } else {
      box = await _openHiveBox<T>(collectionName);
    }
    return await box.clear();
  }

  @override
  Future<void> closeCollection<T>({
    required final String collectionName,
  }) async {
    if (Hive.isBoxOpen(collectionName)) {
      unawaited(Hive.box<T>(collectionName).close());
    }
  }

  Future<Box<T>> _openHiveBox<T>(
    final String collectionName,
  ) async =>
      await Hive.openBox<T>(
        encryptionCipher:
            _securedKey != null ? HiveAesCipher(_securedKey!) : null,
        collectionName,
      );

  @override
  Future<void> init() async {
    await _initFunction();
  }

  @override
  Future<void> release() async {}
}

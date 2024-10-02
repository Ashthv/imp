import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tcs_dff_storage/cache/cache.dart';
import 'package:tcs_dff_storage/cache/cache_item.dart';
import 'package:tcs_dff_storage/cache/cache_utils.dart';
import 'package:tcs_dff_test/dff_mocks.dart';
import 'package:tcs_dff_types/tcs_dff_types.dart';

void main() {
  setUp(() {
    dff = MockDffPlatform();
  });

  test('get item from the cache', () async {
    final json = jsonEncode(
      CacheItem(
        key: 'testKey',
        data: 'data',
        expiryTime: getExpiryDate(duration: const Duration(minutes: 1)),
      ),
    );
    when(
      () => dff.storage.getItem<String>(
        collectionName: 'cache',
        key: 'testKey',
      ),
    ).thenAnswer((final _) async => Future.value(json));
    final cache = Cache();
    final cacheItem = await cache.getItem(
      key: 'testKey',
    );
    verify(
      () => dff.storage.getItem<String>(
        collectionName: 'cache',
        key: 'testKey',
      ),
    ).called(1);

    expect(cacheItem, 'data');
  });

  test('Set item to the cache', () async {
    final cacheItem = CacheItem(
      key: 'testKey',
      data: 'data',
    );

    when(
      () => dff.storage.setItem<String>(
        collectionName: 'cache',
        key: 'testKey',
        item: jsonEncode(cacheItem),
      ),
    ).thenAnswer((final _) async {});
    final cache = Cache();

    await cache.setItem(key: 'testKey', data: 'data');
  });

  test('get secured item from the cache', () async {
    final json = jsonEncode(
      CacheItem(
        key: 'testKey',
        data: 'secured data',
        expiryTime: getExpiryDate(duration: const Duration(minutes: 1)),
      ),
    );
    when(
      () => dff.sharedPreferences.getSecuredStringValue(key: 'testKey'),
    ).thenAnswer((final _) async => Future.value(json));
    final cache = Cache();
    final cacheItem = await cache.getSecuredItem(
      key: 'testKey',
    );
    verify(
      () => dff.sharedPreferences.getSecuredStringValue(
        key: 'testKey',
      ),
    ).called(1);

    expect(cacheItem, 'secured data');
  });

  test('Set secured item to the cache', () async {
    final cacheItem = CacheItem(
      key: 'testKey',
      data: 'data',
    );

    when(
      () => dff.sharedPreferences.setSecuredStringValue(
        key: 'testKey',
        value: jsonEncode(cacheItem),
      ),
    ).thenAnswer((final _) async {});
     await Cache().setSecuredItem(key: 'testKey', data: 'data');
  });
}

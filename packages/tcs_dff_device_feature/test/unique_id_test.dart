import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tcs_dff_device_feature/unique_device_id/unique_device_id.dart';
import 'package:tcs_dff_storage/cache/cache.dart';

class MockMethodChannel extends Mock implements MethodChannel {}

class MockCache extends Mock implements Cache {}

void main() {
  late UniqueDeviceId uniqueDeviceId;
  late MockMethodChannel mockMethodChannel;
  late MockCache mockCache;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();

    mockMethodChannel = MockMethodChannel();
    mockCache = MockCache();
    uniqueDeviceId = UniqueDeviceId()
      ..deviceIdChannel = mockMethodChannel
      ..cache = mockCache;
  });

  group('UniqueDeviceId', () {
    test('getUniqueDeviceId returns unique device id on success', () async {
      const uniqueDeviceIdValue = 'unique_device_id';

      when(() => mockMethodChannel.invokeMethod<String>('getUniqueDeviceId'))
          .thenAnswer((final _) async => uniqueDeviceIdValue);

      final result = await uniqueDeviceId.getUniqueDeviceId();

      expect(result, uniqueDeviceIdValue);
    });

    test('getUniqueDeviceId handles exception and returns null', () async {
      when(() => mockMethodChannel.invokeMethod<String>('getUniqueDeviceId'))
          .thenThrow(
        PlatformException(code: 'ERROR', message: 'An error occurred'),
      );

      final result = await uniqueDeviceId.getUniqueDeviceId();

      expect(result, null);
    });

    test('getAndroidUUIDId returns cached UUID if available', () async {
      const cachedUuid = 'cached_uuid';
      when(() => mockCache.getItem(key: uniqueDeviceId.uuidCacheKey))
          .thenAnswer((final _) async => cachedUuid);

      final result = await uniqueDeviceId.getAndroidUUIDId();

      expect(result, cachedUuid);
      verify(() => mockCache.getItem(key: uniqueDeviceId.uuidCacheKey))
          .called(1);
      verifyNever(
        () => mockMethodChannel.invokeMethod<String>('getAndroidUUIDId'),
      );
    });

    test('getAndroidUUIDId fetches and caches UUID if not cached', () async {
      const fetchedUuid = 'fetched_uuid';
      when(() => mockCache.getItem(key: uniqueDeviceId.uuidCacheKey))
          .thenAnswer((final _) async => null);
      when(() => mockMethodChannel.invokeMethod<String>('getAndroidUUIDId'))
          .thenAnswer((final _) async => fetchedUuid);
      when(
        () => mockCache.setItem(
          key: uniqueDeviceId.uuidCacheKey,
          data: fetchedUuid,
          expiryTime: uniqueDeviceId.cacheDuration,
        ),
      ).thenAnswer((final _) async {});

      final result = await uniqueDeviceId.getAndroidUUIDId();

      expect(result, fetchedUuid);
      verify(() => mockCache.getItem(key: uniqueDeviceId.uuidCacheKey))
          .called(1);
      verify(() => mockMethodChannel.invokeMethod<String>('getAndroidUUIDId'))
          .called(1);
      verify(
        () => mockCache.setItem(
          key: uniqueDeviceId.uuidCacheKey,
          data: fetchedUuid,
          expiryTime: uniqueDeviceId.cacheDuration,
        ),
      ).called(1);
    });
  });

  test('returns UniqueIds with correct values', () async {
    const fetchedUuid = 'fetched_uuid';

    when(() => mockCache.getItem(key: uniqueDeviceId.uuidCacheKey))
        .thenAnswer((final _) async => null);
    when(() => mockMethodChannel.invokeMethod<String>('getUniqueDeviceId'))
        .thenAnswer((final _) => Future.value('unique_device_id'));
    when(() => mockMethodChannel.invokeMethod<String>('getAndroidUUIDId'))
        .thenAnswer((final _) => Future.value('android_uuid'));
    when(
      () => mockCache.setItem(
        key: uniqueDeviceId.uuidCacheKey,
        data: fetchedUuid,
        expiryTime: uniqueDeviceId.cacheDuration,
      ),
    ).thenAnswer((final _) async {});
    final uniqueIds = await uniqueDeviceId.getUniqueIds();

    expect(uniqueIds.uniqueDeviced, 'unique_device_id');
    expect(uniqueIds.androidUuid, 'android_uuid');
    expect(uniqueIds.fid, null);
  });
}

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tcs_dff_cipher/tcs_dff_cipher.dart';
import 'package:tcs_dff_network/encryption_manager.dart';
import 'package:tcs_dff_network/http_network_configuration.dart';
import 'package:tcs_dff_test/dff_mocks.dart';
import 'package:tcs_dff_types/tcs_dff_types.dart';

class MockHTTPNetworkConfiguration extends Mock
    implements HTTPNetworkConfiguration {}

class FakeFuture<T> extends Mock implements Future<T> {}

class MockMethodChannel extends Mock implements MethodChannel {
  MockMethodChannel() {
    registerFallbackValue(FakeFuture<String?>());
    when(() => invokeMethod<String>(any(), any()))
        .thenAnswer((final _) => Future.value('mockdata'));
  }

  @override
  Future<T?> invokeMethod<T>(
    final String method, [
    final dynamic arguments,
  ]) =>
      super.noSuchMethod(
        Invocation.method(#invokeMethod, [method, arguments]),
      ) as Future<T?>;
}

void main() {
  late EncryptionManager encryptionManager;
  late MockHTTPNetworkConfiguration mockNetworkConfiguration;
  late MockMethodChannel mockMethodChannel;
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
  });
  setUp(() {
    mockNetworkConfiguration = MockHTTPNetworkConfiguration();
    dff = MockDffPlatform();
    mockMethodChannel = MockMethodChannel();
    Cipher.platform = mockMethodChannel;
    encryptionManager = EncryptionManager();
  });

  group('EncryptionManager', () {
    test('generateEncryptedHeaderKeys generates and encrypts keys correctly',
        () async {
      when(() => mockNetworkConfiguration.rsaPublicKey)
          .thenAnswer((final invocation) => 'rsaPublicKey');
      final result = await encryptionManager
          .generateEncryptedHeaderKeys(mockNetworkConfiguration);

      expect(result['aesEncryptedHKey'], 'mockdata');
      expect(result['aesEncryptedBKey'], 'mockdata');
      expect(result['aesHeaderKey'], 'mockdata');
      expect(result['aesBodyKey'], 'mockdata');
    });

    test('saveEncryptedKeys saves keys correctly', () {
      final encryptedKeys = {
        'aesHeaderKey': 'mockAESHeaderKey',
        'aesBodyKey': 'mockAESBodyKey',
      };

      when(
        () => dff.storage.setItem<Map<String, String>>(
          collectionName: 'HEADER_BODY_KEYS',
          key: 'aesKeys',
          item: {
            'aesHeaderKey': encryptedKeys['aesHeaderKey']!,
            'aesBodyKey': encryptedKeys['aesBodyKey']!,
          },
        ),
      ).thenAnswer((final _) async {});

      encryptionManager.saveEncryptedKeys(encryptedKeys);

      verify(
        () => dff.storage.setItem<Map<String, String>>(
          collectionName: 'HEADER_BODY_KEYS',
          key: 'aesKeys',
          item: {
            'aesHeaderKey': encryptedKeys['aesHeaderKey']!,
            'aesBodyKey': encryptedKeys['aesBodyKey']!,
          },
        ),
      ).called(1);
    });

    test('encryptBodyData encrypts data correctly', () async {
      when(() => mockNetworkConfiguration.rsaPublicKey)
          .thenAnswer((final invocation) => 'rsaPublicKey');
      await encryptionManager
          .generateEncryptedHeaderKeys(mockNetworkConfiguration);

      final enc = await encryptionManager.encryptBodyData('{"data":"test"}');

      expect(enc, 'mockdata');
    });

    test('decryptBodyData decrypts data correctly', () async {
      when(() => mockNetworkConfiguration.rsaPublicKey)
          .thenAnswer((final invocation) => 'rsaPublicKey');
      await encryptionManager
          .generateEncryptedHeaderKeys(mockNetworkConfiguration);
      final result =
          await encryptionManager.decryptBodyData('mockEncryptedData');

      expect(result, 'mockdata');
    });
  });
}

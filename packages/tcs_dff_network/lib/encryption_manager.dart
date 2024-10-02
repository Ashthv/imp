import 'package:tcs_dff_cipher/tcs_dff_cipher.dart';
import 'package:tcs_dff_types/tcs_dff_types.dart';
import 'http_network_configuration.dart';

class EncryptionManager {
  final Map<String, String> _encryptedKeys = {};
  final initializationVector = 'TW9oYW1tYWRBYmR1bEJhc2l0aA'.substring(1, 17);

  Future<Map<String, String>> generateEncryptedHeaderKeys(
    final HTTPNetworkConfiguration networkConfiguration,
  ) async {
    final String aesHeaderKey, rsaHeaderKey, aesBodyKey, rsaBodyKey;

    // Generate AES key for header
    // AES key should be encrypted with RSA to be sent with generate session API
    aesHeaderKey = (await Cipher.generateAESKey())!;
    rsaHeaderKey = (await Cipher.encryptDataWithRSA(
      plainText: aesHeaderKey,
      rsaPublicKey: networkConfiguration.rsaPublicKey,
    ))!;

    // Generate AES key for header
    // AES key should be encrypted with RSA to be sent with generate session API
    aesBodyKey = (await Cipher.generateAESKey())!;
    rsaBodyKey = (await Cipher.encryptDataWithRSA(
      plainText: aesBodyKey,
      rsaPublicKey: networkConfiguration.rsaPublicKey,
    ))!;

    _encryptedKeys['aesEncryptedHKey'] =
        rsaHeaderKey; // AES header key encrypted using RSA
    _encryptedKeys['aesEncryptedBKey'] =
        rsaBodyKey; // AES body key encrypted using RSA
    _encryptedKeys['aesHeaderKey'] = aesHeaderKey; // AES header key
    _encryptedKeys['aesBodyKey'] = aesBodyKey; // AES body key

    return _encryptedKeys;
  }

  void saveEncryptedKeys(final Map<String, String> encryptedKeys) {
    dff.storage.setItem<Map<String, String>>(
      collectionName: 'HEADER_BODY_KEYS',
      key: 'aesKeys',
      item: {
        'aesHeaderKey': encryptedKeys['aesHeaderKey']!,
        'aesBodyKey': encryptedKeys['aesBodyKey']!,
      },
    );
  }

  Future<Object?> encryptBodyData(
    final Object jsonBody,
  ) async {
    final aesBodyKey = _encryptedKeys['aesBodyKey']
        as String; // _retrieveEncryptedKeys() as Map<String, String>;
    if (aesBodyKey.isNotEmpty) {
      return await Cipher.encryptDataWithAES(
        plainText: jsonBody.toString(),
        key: aesBodyKey,
        initializationVector: initializationVector,
      );
    }
    return null;
  }

  Future<Object?> decryptBodyData(
    final Object jsonBody,
  ) async {
    final aesBodyKey = _encryptedKeys['aesBodyKey'] as String;
    if (aesBodyKey.isNotEmpty) {
      return await Cipher.decryptDataWithAES(
        cipherText: jsonBody.toString(),
        key: aesBodyKey,
        initializationVector: initializationVector,
      );
    }
    return null;
  }
}

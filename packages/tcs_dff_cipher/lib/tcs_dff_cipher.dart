library tcs_dff_cipher;

import 'package:flutter/services.dart';

class Cipher {
  static MethodChannel platform = const MethodChannel('com.dff.cipher');

  static Future<String?> generateAESKey() async =>
      await platform.invokeMethod<String>('generateAESKey', {'keySize': 128});

  static Future<String?> encryptData({
    required final String plainText,
    required final String aesKey,
    required final String rsaPublicKey,
    required final String initializationVector,
  }) async =>
      encryptDataWithRSA(
        plainText: (await encryptDataWithAES(
          plainText: plainText,
          key: aesKey,
          initializationVector: initializationVector,
        ))!,
        rsaPublicKey: rsaPublicKey,
      );

  static Future<String?> encryptDataWithAES({
    required final String plainText,
    required final String key,
    required final String initializationVector,
  }) async =>
      await platform.invokeMethod<String>('encrypt', {
        'plainText': plainText,
        'key': key,
        'algorithmName': 'AES',
        'transformation': 'AES/CBC/PKCS5PADDING',
        'initializationVector': initializationVector,
      });

  static Future<String?> decryptDataWithAES({
    required final String cipherText,
    required final String key,
    required final String initializationVector,
  }) async =>
      await platform.invokeMethod<String>('decrypt', {
        'cipherText': cipherText,
        'key': key,
        'algorithmName': 'AES',
        'transformation': 'AES/CBC/PKCS5PADDING',
        'initializationVector': initializationVector,
      });

  static Future<String?> encryptDataWithRSA({
    required final String plainText,
    required final String rsaPublicKey,
  }) async =>
      await platform.invokeMethod('encrypt', {
        'plainText': plainText,
        'key': rsaPublicKey,
        'algorithmName': 'RSA',
        'transformation': 'RSA/ECB/PKCS1PADDING',
        'initializationVector': '',
      });

  static Future<String?> decryptDataWithRSA({
    required final String cipherText,
    required final String rsaPrivateKey,
  }) async =>
      await platform.invokeMethod<String>('decrypt', {
        'cipherText': cipherText,
        'key': rsaPrivateKey,
        'algorithmName': 'RSA',
        'transformation': 'RSA/ECB/PKCS1PADDING',
        'initializationVector': '',
      });
}

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tcs_dff_cipher/tcs_dff_cipher.dart';

void main() {
  const aesKey = 'uWqUc4XK0v04A+DlwWytCw==';
  const plainText = 'Text to encrypt and decrypt!!!';
  const cipherText = 'tsrK0q9ZilWBafUFJ8+6Zsri2ggU9TSO51rL5KIXtUg=';
  const rsaPublicKey =
      'MF0wDQYJKoZIhvcNAQEBBQADTAAwSQJCMAEXpIGJncqu+Nl9NQPVvrQMwsK/5LRC1svomZgl4NlyMnazBmEN7nS16Y7DGgAAcw9yiBardKsH1g8+5KTXXSkzAgMBAAE=';
  const rsaPrivateKey =
      'MIIBWQIBADANBgkqhkiG9w0BAQEFAASCAUMwggE/AgEAAkIwARekgYmdyq742X01A9W+tAzCwr/ktELWy+iZmCXg2XIydrMGYQ3udLXpjsMaAABzD3KIFqt0qwfWDz7kpNddKTMCAwEAAQJCIaqCdELMyrb841VUdDvOScJoOKbwgWrSfWXgKOgFmJ2m13wNQQu+psqx6LtE4MKV30V7JoNTizXeHMlwcBbbdB9xAiF02rVRTLiRQGEuTHGF/bEMh7vd3CYezSUPB9Aqo+JC1IUCIWkqeVnoNgZ5j1ceSLuuJYy4bMDlJXb3RAXZEtxRV/YwVwIhbpiM4Wx2huriz1oEW+e2yQAyW5G/9oj8mRQw/hprzAqtAiEcThFBUI2R6o/Y6865rOJwYIbs1//gaCbHyCgaYk5hdZsCIWYseMyZH39sGIPJ0ht1x9Mlu8ZtJmKm8xY6mCxvsHAbaA==';
  final initializationVector = 'TW9oYW1tYWRBYmR1bEJhc2l0aA'.substring(1, 17);

  setUp(() async {});

  testWidgets('Generate AES key', (final widgetTester) async {
    const methodChannel = MethodChannel('com.dff.cipher');
    widgetTester.binding.defaultBinaryMessenger
        .setMockMethodCallHandler(methodChannel, (final methodCall) async {
      if (methodCall.method == 'generateAESKey') {
        return 'uWqUc4XK0v04A+DlwWytCw==';
      }
      return null;
    });

    final result = await Cipher.generateAESKey();

    expect(result, equals('uWqUc4XK0v04A+DlwWytCw=='));
  });

  testWidgets('Encryption Data with aes', (final widgetTester) async {
    const methodChannel = MethodChannel('com.dff.cipher');

    widgetTester.binding.defaultBinaryMessenger
        .setMockMethodCallHandler(methodChannel, (final methodCall) async {
      if (methodCall.method == 'encrypt') {
        return 'tsrK0q9ZilWBafUFJ8+6Zsri2ggU9TSO51rL5KIXtUg=';
      }
      return null;
    });

    final result = await Cipher.encryptDataWithAES(
      plainText: plainText,
      key: aesKey,
      initializationVector: initializationVector,
    );

    expect(result, equals(cipherText));
  });

  testWidgets('Encryption Data', (final widgetTester) async {
    const methodChannel = MethodChannel('com.dff.cipher');

    widgetTester.binding.defaultBinaryMessenger
        .setMockMethodCallHandler(methodChannel, (final methodCall) async {
      if (methodCall.method == 'encrypt') {
        return 'tsrK0q9ZilWBafUFJ8+6Zsri2ggU9TSO51rL5KIXtUg=';
      }
      return null;
    });

    final result = await Cipher.encryptData(
      plainText: plainText,
      aesKey: aesKey,
      rsaPublicKey: rsaPublicKey,
      initializationVector: initializationVector,
    );

    expect(result, equals(cipherText));
  });

  testWidgets('Decrypt Data', (final widgetTester) async {
    const methodChannel = MethodChannel('com.dff.cipher');

    widgetTester.binding.defaultBinaryMessenger
        .setMockMethodCallHandler(methodChannel, (final methodCall) async {
      if (methodCall.method == 'decrypt') {
        return 'Text to encrypt and decrypt!!!';
      }
      return null;
    });

    final result = await Cipher.decryptDataWithAES(
      cipherText: cipherText,
      key: aesKey,
      initializationVector: initializationVector,
    );

    expect(result, equals(plainText));
  });

  testWidgets('Encryption Data with RSA', (final widgetTester) async {
    const methodChannel = MethodChannel('com.dff.cipher');

    widgetTester.binding.defaultBinaryMessenger
        .setMockMethodCallHandler(methodChannel, (final methodCall) async {
      if (methodCall.method == 'encrypt') {
        return cipherText;
      }
      return null;
    });

    final result = await Cipher.encryptDataWithRSA(
      plainText: plainText,
      rsaPublicKey: rsaPublicKey,
    );

    expect(result, equals(cipherText));
  });
  testWidgets('Decrypt Data with RSA', (final widgetTester) async {
    const methodChannel = MethodChannel('com.dff.cipher');

    widgetTester.binding.defaultBinaryMessenger
        .setMockMethodCallHandler(methodChannel, (final methodCall) async {
      if (methodCall.method == 'decrypt') {
        return plainText;
      }
      return null;
    });

    final result = await Cipher.decryptDataWithRSA(
      cipherText: cipherText,
      rsaPrivateKey: rsaPrivateKey,
    );

    expect(result, equals(plainText));
  });
}

import 'package:flutter/material.dart';
import 'package:tcs_dff_cipher/tcs_dff_cipher.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';

class CipherScreen extends StatefulWidget {
  const CipherScreen({super.key});

  @override
  State<CipherScreen> createState() => _CipherScreenState();
}

class _CipherScreenState extends State<CipherScreen> {
  String genertedKey = '';
  String textToEncryptDecrypt = 'Text to encrypt and decrypt!!!!';
  String cipherText = '';
  String plainText = 'Text to encrypt and decrypt!!!';
  String rsaPublicKey =
      'MF0wDQYJKoZIhvcNAQEBBQADTAAwSQJCMAEXpIGJncqu+Nl9NQPVvrQMwsK/5LRC1svomZgl4NlyMnazBmEN7nS16Y7DGgAAcw9yiBardKsH1g8+5KTXXSkzAgMBAAE=';
  String rsaPrivateKey =
      'MIIBWQIBADANBgkqhkiG9w0BAQEFAASCAUMwggE/AgEAAkIwARekgYmdyq742X01A9W+tAzCwr/ktELWy+iZmCXg2XIydrMGYQ3udLXpjsMaAABzD3KIFqt0qwfWDz7kpNddKTMCAwEAAQJCIaqCdELMyrb841VUdDvOScJoOKbwgWrSfWXgKOgFmJ2m13wNQQu+psqx6LtE4MKV30V7JoNTizXeHMlwcBbbdB9xAiF02rVRTLiRQGEuTHGF/bEMh7vd3CYezSUPB9Aqo+JC1IUCIWkqeVnoNgZ5j1ceSLuuJYy4bMDlJXb3RAXZEtxRV/YwVwIhbpiM4Wx2huriz1oEW+e2yQAyW5G/9oj8mRQw/hprzAqtAiEcThFBUI2R6o/Y6865rOJwYIbs1//gaCbHyCgaYk5hdZsCIWYseMyZH39sGIPJ0ht1x9Mlu8ZtJmKm8xY6mCxvsHAbaA==';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            ElevatedButton(
              onPressed: () async {
                genertedKey = (await Cipher.generateAESKey())!;
                // DffLogger.log("genratedKey:" + genertedKey);
                setState(() {});
              },
              child: const Text('Generate AES Key'),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(genertedKey),
            const SizedBox(
              height: 8,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        cipherText = (await Cipher.encryptDataWithAES(
                          plainText: plainText,
                          key: genertedKey,
                          initializationVector:
                              'TW9oYW1tYWRBYmR1bEJhc2l0aA'.substring(1, 17),
                        ))!;
                        textToEncryptDecrypt = cipherText;
                        setState(() {
                          print('AES Encrypted Data: $textToEncryptDecrypt');
                        });
                      },
                      child: Text(
                        'AES Encrypt',
                        style: TextStyle(
                          color: context.theme.appColor.greyFullBlack10,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        plainText = (await Cipher.decryptDataWithAES(
                          cipherText: cipherText,
                          key: genertedKey,
                          initializationVector:
                              'TW9oYW1tYWRBYmR1bEJhc2l0aA'.substring(1, 17),
                        ))!;
                        textToEncryptDecrypt = plainText;
                        setState(() {
                          print('AES Decrypted Data: $textToEncryptDecrypt');
                        });
                      },
                      child: const Text('AES Decrypt'),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        cipherText = (await Cipher.encryptDataWithRSA(
                          plainText: genertedKey,
                          rsaPublicKey: rsaPublicKey,
                        ))!;
                        textToEncryptDecrypt = cipherText;

                        setState(() {
                          print('cipher text:$cipherText');
                        });
                      },
                      child: const Text('RSA Encrypt'),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        plainText = (await Cipher.decryptDataWithRSA(
                          cipherText: textToEncryptDecrypt,
                          rsaPrivateKey: rsaPrivateKey,
                        ))!;
                        textToEncryptDecrypt = plainText;

                        setState(() {
                          print('Plain text:$plainText');
                        });
                      },
                      child: Text(
                        'RSA Decrypt',
                        style: TextStyle(
                          color: context.theme.appColor.greyFullBlack10,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            Text(
              textToEncryptDecrypt,
              style: TextStyle(color: context.theme.appColor.greyFullBlack10),
            ),
          ],
        ),
      );
}

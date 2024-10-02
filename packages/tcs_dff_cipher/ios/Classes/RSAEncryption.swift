import Flutter
import Security
import CryptoKit
protocol RSAEncryptionProtocol{
    func encryptDataUsingRSA(_ call:FlutterMethodCall, result: @escaping FlutterResult);
}

class RSAEncryption:RSAEncryptionProtocol{
    
    func encryptDataUsingRSA(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
         guard let arguments = call.arguments else {
                  return
              }
            let params = arguments as? [String: Any]
             let  algorithmName = params?["algorithmName"] as? String
             let  plainText = params?["plainText"] as? String
             let  encryptionKey = params?["key"] as? String

            if let rsaPublicKey = self.createRSAPublicKeyFromString(publicKey: encryptionKey!, result:result){
            if let encryptedData = self.encryptDataWithRSAPublicKey(data: plainText!, publicKey: rsaPublicKey, result: result){
                 result("\(encryptedData.base64EncodedString())")
            }else {
                result(FlutterError(code: "RSAEncryptionError", message: "Error while encrypting the data", details: nil))
            }
        }else {
          result(FlutterError(code: "RSA key error", message: "Error while creating RSA public key", details: nil))
        }
    }

  private  func createRSAPublicKeyFromString(publicKey:String, result: @escaping FlutterResult) -> SecKey?{
        var _publicKey = publicKey
        // Remove headers and footers from the string
        [
            "-----BEGIN RSA PUBLIC KEY-----", "-----END RSA PUBLIC KEY-----",
            "-----BEGIN PUBLIC KEY-----", "-----END PUBLIC KEY-----"
        ].forEach { _publicKey = _publicKey.replacingOccurrences(of: $0, with: "") }
        
        guard let keyData = Data(base64Encoded: _publicKey, options: .ignoreUnknownCharacters) else {
          result(FlutterError(code: "Key encode error", message: "Error while encoding the key data", details: nil))
            return nil
        }
        
        let attributes: [String: Any] = [  kSecAttrKeyType as String: kSecAttrKeyTypeRSA,
                                           kSecAttrKeyClass as String: kSecAttrKeyClassPublic,
                                           kSecAttrKeySizeInBits as String: 2048
                                           ];
        var error : Unmanaged<CFError>?
        guard let secKey = SecKeyCreateWithData(keyData as CFData, attributes as CFDictionary, &error) else {
            result(FlutterError(code: "RSA key error", message: error.debugDescription, details: nil))
            return nil
        }
        
        
        return secKey;
    }

  private   func encryptDataWithRSAPublicKey(data:String, publicKey:SecKey, result: @escaping FlutterResult) -> Data?{
        let _data = data.data(using: .utf8)! as CFData
        var error : Unmanaged<CFError>?
        let rsaAlgorithm = SecKeyAlgorithm.rsaEncryptionOAEPSHA256 // CHECK WITH RAW
        guard SecKeyIsAlgorithmSupported(publicKey, .encrypt, rsaAlgorithm) else {
             result(FlutterError(code: "RSAAlgorithmError", message: "Encryption algorithm not supported", details: nil))
            return nil
        }
        guard let encryptedData = SecKeyCreateEncryptedData(publicKey, rsaAlgorithm, _data as CFData, &error)else {
            result(FlutterError(code: "RSAEncryptionError", message: error.debugDescription, details: nil))
            return nil
        }
        
        return encryptedData as Data
    }
}
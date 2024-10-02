import Flutter
import Security
import CryptoKit
protocol AESEncryptionProtocol{
    func generateAESKey(_ call:FlutterMethodCall, result: @escaping FlutterResult);
    func encryptDataUsingAES(_ call:FlutterMethodCall, result: @escaping FlutterResult);
    func decrytDataUsingAES(_ call:FlutterMethodCall, result: @escaping FlutterResult);
}

class AESEncryption:AESEncryptionProtocol{

   func generateAESKey(_ call:FlutterMethodCall, result: @escaping FlutterResult) {
        guard let arguments = call.arguments else {
            return 
        }
        let params = arguments as? [String: Any]
        if let  keySize = params?["keySize"] as? Int {
        do{
            let aesKey = try SymmetricKey(size: .init(bitCount: keySize))
            result("\(aesKey.withUnsafeBytes {Data(Array($0)).base64EncodedString()})")
        }catch (let error) {
            result(FlutterError(code: "AESKeyError", message: error.localizedDescription,
            details: nil))
            }
        } 

    }

    func encryptDataUsingAES(_ call: FlutterMethodCall, result: @escaping FlutterResult) {

        guard let arguments = call.arguments else {
         return
        }
        let params = arguments as? [String: Any]
        let algorithmName = params?["algorithmName"] as? String
        let plainText = params?["plainText"] as? String
        let encryptionKey = params?["key"] as? String

        guard let keyData = Data(base64Encoded: encryptionKey!),let textData = plainText!.data(using: .utf8) else {
            result(FlutterError(code: "AESEncodeError",message: "Error while encoding the data",details: nil))
            return 
        }
        let symmetricKey = SymmetricKey(data: keyData)
        do {
            let encryptedData = try AES.GCM.seal(textData, using: symmetricKey).combined
            if let _encryptedData = encryptedData?.base64EncodedString(){
                result("\(_encryptedData)")
            }
        } catch (let error) {
            result(FlutterError(code: "AESEncryptionError", message: error.localizedDescription, details: nil))
        }
    }
    
    func decrytDataUsingAES(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let arguments = call.arguments else {
                  return
              }
            let params = arguments as? [String: Any]
            let algorithmName = params?["algorithmName"] as? String
            let cipherText = params?["cipherText"] as? String
            let encryptionKey = params?["key"] as? String
        guard let keyData = Data(base64Encoded: encryptionKey!),let encryptedData = Data(base64Encoded: cipherText!) else {
                result(FlutterError(code: "AESEncodeError", message: "Error while encoding the data", details: nil))
                return 
              }
            do {
            let symmetricKey = SymmetricKey(data: keyData)
            let sealedBox = try AES.GCM.SealedBox(combined: encryptedData)
            let decryptedData = try AES.GCM.open(sealedBox, using: symmetricKey)
            let decryptedMessage = String(data: decryptedData, encoding: .utf8)
          //  if let  _decryptedData = decryptedData{
                result("\(decryptedData)")
            //}
            } catch (let error) {
                result(FlutterError(code: "AESDecryptionError", message: error.localizedDescription, details: nil))
            }
    }
}
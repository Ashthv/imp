import Flutter
import UIKit
import Security
import CryptoKit
import Flutter

public class CipherPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "com.dff.cipher", binaryMessenger: registrar.messenger())
    let instance = CipherPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }


 public static func handle(_ call:FlutterMethodCall, result: @escaping FlutterResult){

        guard let arguments = call.arguments else {
                  return
              }
            let params = arguments as? [String: Any] 
            let  algorithmName = params?["algorithmName"] as? String

        switch call.method{
            case "generateAESKey":
                let aesEncryption = AESEncryption()
                aesEncryption.generateAESKey(call, result: result)
            case "encrypt" where algorithmName == "AES":
                let aesEncryption = AESEncryption()
                aesEncryption.encryptDataUsingAES(call, result: result)
            case "decrypt":
                let aesDecryption = AESEncryption()
                aesDecryption.decrytDataUsingAES(call, result: result)
            case "encrypt" where algorithmName == "RSA":
                let rsaEncryption = RSAEncryption()
                rsaEncryption.encryptDataUsingRSA(call, result: result)    
            default:
              result(FlutterMethodNotImplemented)
        }
    }
}

//   public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
//     switch call.method {
//     case "getPlatformVersion":
//       result("iOS " + UIDevice.current.systemVersion)
    // default:
    //   result(FlutterMethodNotImplemented)
    // }
//   }


// class Encryption : NSObject, FlutterPlugin{
//     func handle(_ call:FlutterMethodCall, result: @escaping FlutterResult){

//         guard let arguments = call.arguments else {
//                   return
//               }
//             let params = arguments as? [String: Any] 
//             let  algorithmName = params?["algorithmName"] as? String

//         switch call.method{
//             case "generateAESKey":
//             {
//                 let aesEncryption = AESEncryption()
//                 aesEncryption.generateAESKey(call, result: result)
//             }
//             case "encrypt" where algorithmName == "AES":
//             {
//                 let aesEncryption = AESEncryption()
//                 aesEncryption.encryptDataUsingAES(call, result: result)
//             }
//             case "decrypt":
//             {
//                 let aesDecryption = AESEncryption()
//                 aesDecryption.decrytDataUsingAES(call, result: result)
//             }
//             case "encrypt" where algorithmName == "RSA":
//             { 
//                 let rsaEncryption = RSAEncryption()
//                 rsaEncryption.encryptDataUsingRSA(call, result: result)    
               
//             }
//             default:
//               result(FlutterMethodNotImplemented)
    

//         }
//     }





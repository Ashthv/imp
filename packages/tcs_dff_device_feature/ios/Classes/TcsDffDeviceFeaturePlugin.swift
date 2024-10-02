import Flutter
import UIKit
import MessageUI



public class TcsDffDeviceFeaturePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "com.dff.sms_feature", binaryMessenger: registrar.messenger())
    let instance = TcsDffDeviceFeaturePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "sendSMS":
      sendSMS(call, result: result)
    case "getUniqueDeviceId":
      getUniqueDeviceId(result: result)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}

 

extension  TcsDffDeviceFeaturePlugin {
  
  func sendSMS(_ call:FlutterMethodCall, result: @escaping FlutterResult){
    if(MFMessageComposeViewController.canSendText()){
             
             guard let arguments = call.arguments else {
                  return
              }
            let params = arguments as? [String: Any] 
            let  phoneNumber = params?["phoneNumber"] as? String
            let  messageBody = params?["message"] as? String

            //  let messageComposeVC = MFMessageComposeViewController()
            //  messageComposeVC.body = messageBody
            //  messageComposeVC.messageComposeDelegate = self
            //  messageComposeVC.recipients = [phoneNumber]
             
            //  if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let sceneDelegate = windowScene.delegate as? SceneDelegate{
            //      sceneDelegate.window?.rootViewController?.present(messageComposeVC, animated: true)
            //  }

              
        if let url = URL(string: "sms:\(phoneNumber)&body=\(messageBody)"){
            if UIApplication.shared.canOpenURL(url){
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }

         }
         else {
          
         }

  }

  func getUniqueDeviceId (result: @escaping FlutterResult) {
    DispatchQueue.main.async {
          let identifierForVendor = UIDevice.current.identifierForVendor
                           //result.success(identifierForVendor?.uuidString)
                           result(identifierForVendor?.uuidString)

    }
  }
  
}

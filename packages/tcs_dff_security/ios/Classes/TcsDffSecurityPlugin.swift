import Flutter
import UIKit
import CoreLocation
import Network

public class TcsDffSecurityPlugin: NSObject, FlutterPlugin,CLLocationManagerDelegate {
  let locationManager = CLLocationManager()
  var resultCallback: FlutterResult?

  public static func register(with registrar: FlutterPluginRegistrar) {
    

    let channel = FlutterMethodChannel(name: "com.dff.security", binaryMessenger: registrar.messenger())
    let instance = TcsDffSecurityPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    
    switch call.method {
    case "getConnectedWifiInfo":
    
    resultCallback = result;
    locationManager.delegate = self
    locationManager.requestWhenInUseAuthorization()
    
    case "checkVulnerableApps":
      // let vulnerableApps = call.arguments as Array<String>
      // result.success(checkVulnerableApps(vulnerableApps: vulnerableApps))
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}

extension  TcsDffSecurityPlugin {

  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse {
            let monitor = NWPathMonitor()
            monitor.pathUpdateHandler = { path in
                if path.status == .satisfied {
                    let wifiInterface = path.availableInterfaces.filter { $0.type == .wifi }.first
                    if let wifiInterface = wifiInterface {
                        let wifiInfo = wifiInterface.debugDescription
                        self.wifiInfo(wifiInfo)
                    }
                }
            }
            let queue = DispatchQueue(label: "wifiQueue")
            monitor.start(queue: queue)
        } else {
            // print("Location access not granted.")
        }
    }
    
    func wifiInfo(_ info: String) {
        let wifiDetails = info.components(separatedBy: "\n")
        resultCallback(wifiDetails)
        /* 
        TODO: The current string return should be an object simillar as in android call back.
         Please refer the TcsDffSecurityPlugin.kt android file for the object
        */
        // var ssid = ""
        // var bssid = ""
        // var securityType = ""
        // var frequency = ""
        // var signalLevel = ""
        // var macAddress = ""
        
        // for component in components {
        //     if component.hasPrefix("SSID") {
        //         ssid = component.components(separatedBy: ": ")[1]
        //     } else if component.hasPrefix("BSSID") {
        //         bssid = component.components(separatedBy: ": ")[1]
        //     } else if component.hasPrefix("Security") {
        //         securityType = component.components(separatedBy: ": ")[1]
        //     } else if component.hasPrefix("Channel") {
        //         frequency = component.components(separatedBy: ": ")[1]
        //     } else if component.hasPrefix("Signal Strength") {
        //         signalLevel = component.components(separatedBy: ": ")[1]
        //     } else if component.hasPrefix("HW Address") {
        //         macAddress = component.components(separatedBy: ": ")[1]
        //     }
        // }
        
        // let isSecure = securityType.contains("WPA") || securityType.contains("WEP") || securityType.contains("Enterprise")
        
        // print("SSID: \(ssid)")
        // print("BSSID: \(bssid)")
        // print("Security Type: \(securityType)")
        // print("Frequency: \(frequency)")
        // print("Signal Level: \(signalLevel)")
        // print("MAC Address: \(macAddress)")
        // print("Is Secure: \(isSecure)")
        
        
    }

    /* 
      TODO: checkVulnerableApps requires testing in iOS
    */
    // func checkVulnerableApps(vulnerableApps: Array<String>) -> Bool {
    //   let isVulnerableApp = false

    //   for schemaName in vulnerableApps {
    //     isVulnerableApp = UIApplication.shared.canOpenURL(url: URL(string: "\(schemaName)://"))
        
    //     if (isVulnerableApp) break
    //   }

    //   return isVulnerableApp
    // }
}


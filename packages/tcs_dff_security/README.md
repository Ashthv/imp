# tcs_dff_security

A new Flutter plugin project.

## Getting Started

Security class has a static method isWifiSecured(), to verify if the connected Wifi is Password protected or open. It has a method channel to get data from respective platforms.

## Logic of Android

There are 2 different logic used here. One is for android API 31 and above and other for API below 31. We get the a custom WifiInfo object for method channel. In the received obj we have added String `securityType`. If it has keywords `PSK`, `WEP`, `SAE` or `OWE` the the Wifi connection is considered to be Secured else Insecure.

We have implemented Stream<NativeWifiInfo> with the help of [connectivity plugin](https://pub.dev/packages/connectivity_plus). This plugin is used to detect change in network connection state. Once the stream is started, it observes network state. If network state is found as wifi then method channel code is called to check if the currently connected wifi is open or secured. If open, stream emits the a NativeWifiInfo obj to its subscriber and alerts insecure wifi connection.

### Logic for API 31 and above

Refer [this](https://developer.android.com/reference/android/net/wifi/WifiInfo#getCurrentSecurityType()). We convert int to respective String types and return to Flutter code. We can not use the same for API 30 and below becaues this method was added in API 31. 

### Login for API 30 and below

First we get the currently connected Wifi ssid with [WifiManager.connectionInfo](https://developer.android.com/reference/kotlin/android/net/wifi/WifiManager#getConnectionInfo()). Then using [wifiManager.scanResults](https://developer.android.com/reference/kotlin/android/net/wifi/WifiManager#getscanresults) get all the properties of available connections. We match the current SSID with all the available ones and fetch its [capabilities](https://developer.android.com/reference/kotlin/android/net/wifi/ScanResult#capabilities:kotlin.String) and return to flutter code. Eg: `[ESS]` for OPEN, `[WPA2-PSK-CCMP][ESS]` -> WPA2-Personal.` Above methods were depericated since API 31.


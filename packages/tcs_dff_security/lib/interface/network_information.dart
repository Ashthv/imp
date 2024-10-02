import 'package:tcs_dff_types/native_wifi_info.dart';
import 'package:tcs_dff_types/proxy_info.dart';

abstract interface class NetworkInformation {
  Future<bool> isCurrentWifiSecure();
  Future<NativeWifiInfo> getNativeWifiInfo();
  Stream<NativeWifiInfo> insecureWifiStream();
  Future<bool> isVPNConnected();
  Stream<bool> connectedVPNStream();
  Future<ProxyInfo> getProxyInfo();
  Stream<ProxyInfo> connectedProxyStream();
  Future<bool> isProxyEnabled();
}

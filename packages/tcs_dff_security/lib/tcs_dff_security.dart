library tcs_dff_security;

import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:tcs_dff_types/native_wifi_info.dart';
import 'package:tcs_dff_types/proxy_info.dart';
import 'implementation/proxy_info_reader_impl.dart';
import 'implementation/vpn_detector_impl.dart';
import 'interface/network_information.dart';
import 'interface/proxy_information.dart';
import 'interface/vpn_detector.dart';

class SecuredNetwork implements NetworkInformation {
  MethodChannel _platform = const MethodChannel('com.dff.security');
  ProxyInfoReader _proxyInfoReader = ProxyInfoReaderImpl();
  VPNDetector _vpnDetector = VPNDetectorImpl();

  @visibleForTesting
  MethodChannel get getPlatform => _platform;

  @visibleForTesting
  set setPlatform(final MethodChannel methodChannel) {
    _platform = methodChannel;
  }

  @visibleForTesting
  ProxyInfoReader get getProxyInfoReader => _proxyInfoReader;

  @visibleForTesting
  set setProxyInfoReader(final ProxyInfoReader proxyInfoReader) {
    _proxyInfoReader = proxyInfoReader;
  }

  @visibleForTesting
  VPNDetector get getVPNDetector => _vpnDetector;

  @visibleForTesting
  set setVPNDetector(final VPNDetector vpnDetector) {
    _vpnDetector = vpnDetector;
  }

  @override
  Future<ProxyInfo> getProxyInfo() async => await _proxyInfoReader.proxySetting;

  @override
  Future<bool> isProxyEnabled() async {
    final proxySetting = await _proxyInfoReader.proxySetting;
    return proxySetting.isEnabled;
  }

  @override
  Stream<ProxyInfo> connectedProxyStream() async* {
    await for (final connectionName in Connectivity().onConnectivityChanged) {
      if (connectionName != ConnectivityResult.none) {
        final proxySetting = await _proxyInfoReader.proxySetting;
        if (proxySetting.isEnabled) {
          yield ProxyInfo(
            isEnabled: proxySetting.isEnabled,
            host: proxySetting.host,
            port: proxySetting.port,
          );
        }
      }
    }
  }

  @override
  Future<bool> isVPNConnected() async => await _vpnDetector.isVPNActive();

  @override
  Stream<bool> connectedVPNStream() async* {
    _vpnDetector.getVpnConnectionStream();
  }

  @override
  Future<NativeWifiInfo> getNativeWifiInfo() async {
    // add a check to see if wifi is enable?
    // await DevicePermissionManager()
    //     .checkAndRequestPermission(DevicePermission.locationWhenInUse);
    final wifiInfoString =
        await _platform.invokeMethod<String>('getConnectedWifiInfo');
    if (wifiInfoString != null && wifiInfoString.isNotEmpty) {
      return NativeWifiInfo.fromJson(
        json.decode(wifiInfoString) as Map<String, dynamic>,
      );
    }
    return NativeWifiInfo();
  }

  @override
  Stream<NativeWifiInfo> insecureWifiStream() async* {
    var wifiInfo = NativeWifiInfo();
    await for (final connectionName in Connectivity().onConnectivityChanged) {
      if (connectionName == ConnectivityResult.wifi) {
        wifiInfo = await getNativeWifiInfo();
        if (!isWifiSecured(securityType: wifiInfo.securityType ?? 'OPEN')) {
          yield wifiInfo;
        }
      }
    }
  }

  @override
  Future<bool> isCurrentWifiSecure() async {
    final wifiInfo = await getNativeWifiInfo();
    return isWifiSecured(securityType: wifiInfo.securityType ?? 'OPEN');
  }

  @visibleForTesting
  bool isWifiSecured({required final String securityType}) {
    if (securityType.contains('PSK') ||
        securityType.contains('WEP') ||
        securityType.contains('SAE') ||
        securityType.contains('OWE')) {
      return true;
    }
    return false;
  }
}

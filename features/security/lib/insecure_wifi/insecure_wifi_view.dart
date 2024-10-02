import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tcs_dff_device_feature/permission/device_permission_manager.dart';
import 'package:tcs_dff_device_feature/permission/permission_types.dart';
import 'package:tcs_dff_security/tcs_dff_security.dart';

class InsecureWifiView extends StatefulWidget {
  const InsecureWifiView({super.key});

  @override
  State<InsecureWifiView> createState() => _InsecureWifiViewState();
}

class _InsecureWifiViewState extends State<InsecureWifiView> {
  String? securityType;
  String? wifiName;
  late final StreamSubscription connectionState;
  @override
  void initState() {
    super.initState();
    initStream();
  }

  Future<void> initStream() async {
    await requestLocationPermission();
    connectionState =
        SecuredNetwork().insecureWifiStream().listen((final wifiInfo) {
      setState(() {
        wifiName = wifiInfo.ssid ?? 'Unknown wifi';
        securityType = wifiInfo.securityType;
      });
    });
  }

  @override
  Widget build(final BuildContext context) => securityType != null
      ? Center(
          child: Text(
            'Currently connected Wifi $wifiName is secure = $securityType',
            style: const TextStyle(color: Colors.black),
          ),
        )
      : const Center(
          child: Column(
            children: [
              Text(
                'Only Insecure wifi will be set to this stream',
                style: TextStyle(color: Colors.black),
              ),
              Text(
                'Make sure you are connected Wifi',
                style: TextStyle(color: Colors.black),
              ),
              Text(
                'Location is on and have its permision',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        );

  @override
  void dispose() {
    connectionState.cancel();
    super.dispose();
  }

  Future<void> requestLocationPermission() async {
    await DevicePermissionManager()
        .checkAndRequestPermission(DevicePermission.locationWhenInUse);
  }
}

import 'dart:io';

import 'package:flutter/services.dart';

import '../interface/vulnerable_information.dart';

class VulnerableDetect implements VulnerableInformation {
  static const _channel = MethodChannel('com.dff.security');

  final List<String> androidPackageNames = [
    'com.anydesk.anydeskandroid',
    'com.isol.E1',
    'com.avvaloffice.flutter_hbb',
    'com.teamviewer.teamviewer.market.mobile',
    'com.teamviewer.quicksupport.market',
    'com.teknopars.AlpemixPro',
    'srthk.pthk.smsforwarder',
    'com.example.sheetkyc',
    'com.freedomrewardz',
    'com.ikycappi.cxzx4',
    'com.islonline.isllight.mobile.android',
  ];

  final List<String> iosSchemaNames = [
    'anydesk',
    'isol',
    'avvaldesk',
    'teamviewerTVCv1',
    'tvqs',
    'isllight',
  ];

  @override
  Future<bool> checkVulnerableApps() async =>
      (await _channel.invokeMethod<bool>(
        'checkVulnerableApps',
        Platform.isAndroid ? androidPackageNames : iosSchemaNames,
      ))!;
}

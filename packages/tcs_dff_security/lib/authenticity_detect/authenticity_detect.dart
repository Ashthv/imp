import 'package:package_info_plus/package_info_plus.dart';

import '../interface/authenticity_information.dart';

class AuthenticityDetect implements AuthenticityInformation {
  final List<String> storeSources = [
    'com.android.vending',
    'com.apple.testflight',
    'com.apple',
  ];

  @override
  Future<bool> checkAppAuthenticity() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final installerStore = packageInfo.installerStore;

    return storeSources.contains(installerStore);
  }
}

import 'package:tcs_dff_types/proxy_info.dart';

abstract interface class ProxyInfoReader {
  Future<ProxyInfo> get proxySetting;
}

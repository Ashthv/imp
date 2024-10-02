import 'package:native_flutter_proxy/native_proxy_reader.dart';
import 'package:tcs_dff_types/proxy_info.dart';

import '../interface/proxy_information.dart';

class ProxyInfoReaderImpl implements ProxyInfoReader {
  @override
  Future<ProxyInfo> get proxySetting async {
    final proxySetting = await NativeProxyReader.proxySetting;
    return ProxyInfo(
      isEnabled: proxySetting.enabled,
      host: proxySetting.host,
      port: proxySetting.port,
    );
  }
}

import 'package:vpn_connection_detector/vpn_connection_detector.dart';

import '../interface/vpn_detector.dart';

class VPNDetectorImpl implements VPNDetector {
  @override
  Future<bool> isVPNActive() async => await VpnConnectionDetector.isVpnActive();

  @override
  Stream<bool> getVpnConnectionStream() async* {
    await for (final vpnConnectionState
        in VpnConnectionDetector().vpnConnectionStream) {
      if (vpnConnectionState == VpnConnectionState.connected) {
        yield true;
      }
    }
  }
}

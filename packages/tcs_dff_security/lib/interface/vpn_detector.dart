// ignore: one_member_abstracts
abstract interface class VPNDetector {
  Future<bool> isVPNActive();

  Stream<bool> getVpnConnectionStream();
}

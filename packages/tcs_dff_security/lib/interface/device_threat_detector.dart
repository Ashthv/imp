abstract interface class DeviceThreatDetector {
  Future<bool?> isDeveloperModeEnabled();

  Future<bool?> isUSBDebuggingEnabled();
}

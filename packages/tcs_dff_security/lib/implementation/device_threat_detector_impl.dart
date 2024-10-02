import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../interface/device_threat_detector.dart';

class DeviceThreatDetectorImpl implements DeviceThreatDetector {
  MethodChannel _platform = const MethodChannel('com.dff.security');

  @visibleForTesting
  MethodChannel get getPlatform => _platform;

  @visibleForTesting
  set setPlatform(final MethodChannel methodChannel) {
    _platform = methodChannel;
  }

  @override
  Future<bool?> isDeveloperModeEnabled() async =>
      Platform.isAndroid || kDebugMode
          ? await _platform.invokeMethod<bool?>('isDeveloperModeEnabled')
          : throw UnsupportedError(
              'Developer mode check is only available for Android.',
            );

  @override
  Future<bool?> isUSBDebuggingEnabled() async =>
      Platform.isAndroid || kDebugMode
          ? await _platform.invokeMethod<bool?>('isUSBDebuggingEnabled')
          : throw UnsupportedError(
              'USB debugging mode check is only available for Android.',
            );
}

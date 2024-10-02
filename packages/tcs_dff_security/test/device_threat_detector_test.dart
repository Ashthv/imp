import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tcs_dff_security/implementation/device_threat_detector_impl.dart';

class MockMethodChannel extends Mock implements MethodChannel {
  @override
  Future<T?> invokeMethod<T>(final String method, [final dynamic arguments]) =>
      super.noSuchMethod(
        Invocation.method(
          #invokeMethod,
          <Object>[method],
          <Symbol, Object?>{},
        ),
        returnValue: Future<T?>.value(false as FutureOr<T?>?),
      ) as Future<T?>;
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  group('Device threat detector test cases', () {
    test('Developer mode true', () async {
      final deviceThreatDetector = DeviceThreatDetectorImpl()
        ..setPlatform = MockMethodChannel();
      when(
        deviceThreatDetector.getPlatform
            .invokeMethod<bool>('isDeveloperModeEnabled'),
      ).thenAnswer(
        (final _) async => true,
      );

      final isDeveloperModeEnabled =
          await deviceThreatDetector.isDeveloperModeEnabled();
      expect(isDeveloperModeEnabled, true);
    });

    test('Developer mode null', () async {
      final deviceThreatDetector = DeviceThreatDetectorImpl()
        ..setPlatform = MockMethodChannel();
      when(
        deviceThreatDetector.getPlatform
            .invokeMethod<bool>('isDeveloperModeEnabled'),
      ).thenAnswer(
        (final _) async => null,
      );

      final isDeveloperModeEnabled =
          await deviceThreatDetector.isDeveloperModeEnabled();
      expect(isDeveloperModeEnabled, null);
    });

    test('Usb debugging true', () async {
      final deviceThreatDetector = DeviceThreatDetectorImpl()
        ..setPlatform = MockMethodChannel();
      when(
        deviceThreatDetector.getPlatform
            .invokeMethod<bool>('isUSBDebuggingEnabled'),
      ).thenAnswer(
        (final _) async => true,
      );

      final isUSBDebuggingEnabled =
          await deviceThreatDetector.isUSBDebuggingEnabled();
      expect(isUSBDebuggingEnabled, true);
    });

    test('Usb debugging null', () async {
      final deviceThreatDetector = DeviceThreatDetectorImpl()
        ..setPlatform = MockMethodChannel();
      when(
        deviceThreatDetector.getPlatform
            .invokeMethod<bool>('isUSBDebuggingEnabled'),
      ).thenAnswer(
        (final _) async => null,
      );

      final isUSBDebuggingEnabled =
          await deviceThreatDetector.isUSBDebuggingEnabled();
      expect(isUSBDebuggingEnabled, null);
    });
  });
}

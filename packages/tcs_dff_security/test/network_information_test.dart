import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tcs_dff_security/interface/proxy_information.dart';
import 'package:tcs_dff_security/interface/vpn_detector.dart';
import 'package:tcs_dff_security/tcs_dff_security.dart';
import 'package:tcs_dff_types/proxy_info.dart';

// Proxy and VPN methods uses static fields of respective dependecies and
// as we can not mock static fields, no test cases written for the same
class MockMethodChannel extends Mock implements MethodChannel {
  @override
  Future<T?> invokeMethod<T>(final String method, [final dynamic arguments]) =>
      super.noSuchMethod(
        Invocation.method(
          #invokeMethod,
          <Object>[method],
          <Symbol, Object?>{},
        ),
        returnValue: Future<T?>.value('' as FutureOr<T?>?),
      ) as Future<T?>;
}

class MockProxyReader extends Mock implements ProxyInfoReader {
  @override
  Future<ProxyInfo> get proxySetting => super.noSuchMethod(
        Invocation.getter(#proxySetting),
        returnValue: Future<ProxyInfo>.value(ProxyInfo(isEnabled: false)),
      ) as Future<ProxyInfo>;
}

class MockVPNDetector extends Mock implements VPNDetector {
  @override
  Future<bool> isVPNActive() => super.noSuchMethod(
        Invocation.getter(#isVPNActive),
        returnValue: Future<bool>.value(false),
      ) as Future<bool>;

  @override
  Stream<bool> getVpnConnectionStream() => super.noSuchMethod(
        Invocation.getter(#getVpnConnectionStream),
        returnValue: Stream<bool>.value(false),
      ) as Stream<bool>;
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  group('WIFI test cases', () {
    test('successfull getWifiInfo', () async {
      final networkInformation = SecuredNetwork()
        ..setPlatform = MockMethodChannel();

      when(
        networkInformation.getPlatform
            .invokeMethod<String?>('getConnectedWifiInfo'),
      ).thenAnswer(
        (final _) async =>
            // ignore: lines_longer_than_80_chars
            '{ "ssid": "TP-LINK-3975", "bssid": "24:A4:3C:9E:D2:84", "macAddress" : "00-B0-D0-63-C2-26", "securityType" : "PSK", "frequency" : 5, "level" : 3, "netWorkId" : 1 }',
      );

      final wifiProperties = await networkInformation.getNativeWifiInfo();
      final isWifiSecured = await networkInformation.isCurrentWifiSecure();

      expect(wifiProperties.ssid, 'TP-LINK-3975');
      expect(wifiProperties.bssid, '24:A4:3C:9E:D2:84');
      expect(wifiProperties.macAddress, '00-B0-D0-63-C2-26');
      expect(wifiProperties.securityType, 'PSK');
      expect(wifiProperties.frequency, 5);
      expect(wifiProperties.level, 3);
      expect(wifiProperties.netWorkId, 1);
      expect(isWifiSecured, true);
    });

    test('null returned failed getWifiInfo', () async {
      final networkInformation = SecuredNetwork()
        ..setPlatform = MockMethodChannel();

      when(
        networkInformation.getPlatform
            .invokeMethod<String?>('getConnectedWifiInfo'),
      ).thenAnswer(
        (final _) async => null,
      );

      final wifiProperties = await networkInformation.getNativeWifiInfo();
      final isWifiSecured = await networkInformation.isCurrentWifiSecure();

      expect(wifiProperties, isNotNull);
      expect(wifiProperties.ssid, null);
      expect(wifiProperties.bssid, null);
      expect(wifiProperties.macAddress, null);
      expect(wifiProperties.securityType, null);
      expect(wifiProperties.frequency, null);
      expect(wifiProperties.level, null);
      expect(wifiProperties.netWorkId, null);
      expect(isWifiSecured, false);
    });

    test('empty returned failed getWifiInfo', () async {
      final networkInformation = SecuredNetwork()
        ..setPlatform = MockMethodChannel();

      when(
        networkInformation.getPlatform
            .invokeMethod<String?>('getConnectedWifiInfo'),
      ).thenAnswer(
        (final _) async => '',
      );

      final wifiProperties = await networkInformation.getNativeWifiInfo();
      final isWifiSecured = await networkInformation.isCurrentWifiSecure();

      expect(wifiProperties, isNotNull);
      expect(wifiProperties.ssid, null);
      expect(wifiProperties.bssid, null);
      expect(wifiProperties.macAddress, null);
      expect(wifiProperties.securityType, null);
      expect(wifiProperties.frequency, null);
      expect(wifiProperties.level, null);
      expect(wifiProperties.netWorkId, null);
      expect(isWifiSecured, false);
    });

    test('testing isWifiSecured() with different types of input', () async {
      final networkInformation = SecuredNetwork();

      final inputList = <String>[
        '',
        'Open',
        'Unknown',
        'dummy!#213',
        'PSK',
        'WEP',
        'SAE',
        'OWE',
      ];

      final expectedAnsList = <bool>[
        false,
        false,
        false,
        false,
        true,
        true,
        true,
        true,
        true,
      ];

      for (var i = 0; i < inputList.length; i++) {
        expect(
          networkInformation.isWifiSecured(
            securityType: inputList.elementAt(i),
          ),
          expectedAnsList.elementAt(i),
        );
      }
    });
  });

  group('Proxy test cases', () {
    test('proxyInfo when proxy is ON', () async {
      final networkInformation = SecuredNetwork()
        ..setProxyInfoReader = MockProxyReader();

      when(
        networkInformation.getProxyInfoReader.proxySetting,
      ).thenAnswer(
        (final _) async =>
            ProxyInfo(isEnabled: true, host: '10.0.0.1', port: 9090),
      );

      final proxyProperties = await networkInformation.getProxyInfo();
      final isProxyEnabled = await networkInformation.isProxyEnabled();

      expect(proxyProperties.isEnabled, true);
      expect(proxyProperties.host, '10.0.0.1');
      expect(proxyProperties.port, 9090);
      expect(isProxyEnabled, true);
    });

    test('proxyInfo when proxy is OFF', () async {
      final networkInformation = SecuredNetwork()
        ..setProxyInfoReader = MockProxyReader();

      when(
        networkInformation.getProxyInfoReader.proxySetting,
      ).thenAnswer(
        (final _) async => ProxyInfo(
          isEnabled: false,
        ),
      );

      final proxyProperties = await networkInformation.getProxyInfo();
      final isProxyEnabled = await networkInformation.isProxyEnabled();

      expect(proxyProperties.isEnabled, false);
      expect(proxyProperties.host, null);
      expect(proxyProperties.port, null);
      expect(isProxyEnabled, false);
    });
  });

  group('VPN test cases', () {
    test('vpn ON', () async {
      final networkInformation = SecuredNetwork()
        ..setVPNDetector = MockVPNDetector();

      when(
        networkInformation.getVPNDetector.isVPNActive(),
      ).thenAnswer(
        (final _) async => true,
      );

      final isVPNConnected = await networkInformation.isVPNConnected();

      expect(isVPNConnected, true);
    });

    test('vpn OFF', () async {
      final networkInformation = SecuredNetwork()
        ..setVPNDetector = MockVPNDetector();

      when(
        networkInformation.getVPNDetector.isVPNActive(),
      ).thenAnswer(
        (final _) async => false,
      );

      final isVPNConnected = await networkInformation.isVPNConnected();

      expect(isVPNConnected, false);
    });

    test('vpn stream', () async* {
      final networkInformation = SecuredNetwork()
        ..setVPNDetector = MockVPNDetector();

      when(
        networkInformation.getVPNDetector.getVpnConnectionStream(),
      ).thenAnswer(
        (final _) async* {
          yield true;
          yield true;
        },
      );

      final stream = networkInformation.connectedVPNStream();

      await expectLater(
        stream,
        emitsInOrder([
          true,
          true,
        ]),
      );
    });
  });
}

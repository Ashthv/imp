import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tcs_dff_device_feature/permission/device_permission_manager.dart';
import 'package:tcs_dff_device_feature/permission/permission_types.dart';
import 'package:tcs_dff_device_feature/sms_feature/otp_details.dart';
import 'package:tcs_dff_device_feature/sms_feature/receive_sms_template.dart';
import 'package:tcs_dff_device_feature/sms_feature/sim_detail.dart';
import 'package:tcs_dff_device_feature/sms_feature/sms_feature.dart';
import 'package:tcs_dff_storage/cache/cache.dart';
import 'package:tcs_dff_types/exceptions.dart';

class MockMethodChannel extends Mock implements MethodChannel {
  MockMethodChannel() {
    registerFallbackValue(FakeFuture<String?>());
    when(() => invokeMethod<String>(any(), any()))
        .thenAnswer((final _) => Future.value('SMS sent successfully'));
  }

  @override
  Future<T?> invokeMethod<T>(
    final String method, [
    final dynamic arguments,
  ]) =>
      super.noSuchMethod(
        Invocation.method(#invokeMethod, [method, arguments]),
      ) as Future<T?>;
}

class MockEventChannel extends Mock implements EventChannel {}

class MockMethodCall extends Mock implements MethodCall {}

class FakeFuture<T> extends Mock implements Future<T> {}

class MockDevicePermissionManager extends Mock
    implements DevicePermissionManager {}

class MockCache extends Mock implements Cache {
  @override
  Future<void> setItem({
    required final String key,
    required final String data,
    final Duration? expiryTime,
  }) async =>
      Future.value();
}

class FakePermission extends Fake implements Permission {}

void main() {
  late SMSFeature smsFeature;
  late MockMethodChannel mockMethodChannel;
  late MockDevicePermissionManager mockDevicePermissionManager;
  late MockCache mockCache;
  late MockEventChannel mockEventChannel;
  late MockMethodCall mockMethodCall;
  late StreamController<String> streamController;

  setUpAll(() {
    registerFallbackValue(FakePermission());
    mockMethodChannel = MockMethodChannel();
    mockDevicePermissionManager = MockDevicePermissionManager();
    mockCache = MockCache();
    mockEventChannel = MockEventChannel();
    mockMethodCall = MockMethodCall();
    smsFeature = SMSFeature()
      ..methodChannel = mockMethodChannel
      ..devicePermissionManager = mockDevicePermissionManager
      ..cache = mockCache
      ..eventChannel = mockEventChannel;
  });

  test('yields SIM details when permission is granted and SIM details change',
      () async {
    streamController = StreamController<String>();

    when(
      () => mockDevicePermissionManager
          .checkAndRequestPermission(DevicePermission.phone),
    ).thenAnswer((final _) async => DevicePermissionStatus.granted);

    final cacheSimDetails = <SIMDetail>[
      SIMDetail(subscriptionID: '12', simSlotIndex: '0'),
    ];
    when(() => mockCache.getItem(key: 'simInfoKey'))
        .thenAnswer((final _) async => jsonEncode(cacheSimDetails));

    final currentSimDetails = <SIMDetail>[
      SIMDetail(subscriptionID: '1', simSlotIndex: '0'),
    ];
    streamController.add(jsonEncode(currentSimDetails));

    when(() => mockEventChannel.receiveBroadcastStream())
        .thenAnswer((final _) => streamController.stream);

    smsFeature
        .onSIMChangeInformation()
        .listen((final List<SIMDetail> emittedValues) {
      expect(
        emittedValues[0].subscriptionID,
        currentSimDetails[0].subscriptionID,
      );
      streamController.close();
    });
  });

  test('getSIMInformation() returns cached data if available', () async {
    final cachedData = [SIMDetail(subscriptionID: '1234', simSlotIndex: '0')];
    when(() => mockCache.getItem(key: 'simInfoKey'))
        .thenAnswer((final _) async => jsonEncode(cachedData));
    when(() => mockDevicePermissionManager.checkAndRequestPermission(any()))
        .thenAnswer((final _) async => DevicePermissionStatus.granted);

    final result = await smsFeature.getSIMInformation();

    expect(result[0].subscriptionID, cachedData[0].subscriptionID);
    verifyNever(() => mockMethodChannel.invokeMethod(any()));
  });

  test('getSIMInformation() returns data without cache', () async {
    when(() => mockCache.getItem(key: 'simInfoKey'))
        .thenAnswer((final _) async => null);

    final simDetails = [
      SIMDetail(subscriptionID: '123', simSlotIndex: '0'),
    ];
    when(() => mockMethodChannel.invokeMethod<String>('getSimInfo'))
        .thenAnswer((final _) async => jsonEncode(simDetails));
    when(() => mockDevicePermissionManager.checkAndRequestPermission(any()))
        .thenAnswer((final _) async => DevicePermissionStatus.granted);

    final result = await smsFeature.getSIMInformation();

    expect(result[0].subscriptionID, simDetails[0].subscriptionID);
  });

  test('throws DevicePermissionException when permission is denied', () async {
    when(
      () => mockDevicePermissionManager
          .checkAndRequestPermission(DevicePermission.phone),
    ).thenAnswer((final _) async => DevicePermissionStatus.denied);
    when(() => mockCache.getItem(key: 'simInfoKey'))
        .thenAnswer((final _) async => null);
    await expectLater(
      smsFeature.getSIMInformation(),
      throwsA(isA<DevicePermissionException>()),
    );
  });

  test('sends SMS when permission is granted', () async {
    const simSubscriptionId = '1234';
    const toPhoneNumber = '123';
    const sms = 'Hello, world!';
    const sentResult = 'SMS sent successfully';

    when(
      () => mockDevicePermissionManager.checkAndRequestPermission(any()),
    ).thenAnswer((final _) async => DevicePermissionStatus.granted);

    when(() => mockMethodChannel.invokeMethod<String>('sendSMS', any))
        .thenAnswer((final _) async => sentResult);

    final result =
        await smsFeature.sendSMS(simSubscriptionId, toPhoneNumber, sms);

    expect(result, sentResult);
  });

  test('throws DevicePermissionException when permission is denied', () async {
    const simSubscriptionId = '1234';
    const toPhoneNumber = '123';
    const sms = 'Hello, world!';

    when(
      () => mockDevicePermissionManager.checkAndRequestPermission(any()),
    ).thenAnswer((final _) async => DevicePermissionStatus.denied);

    expect(
      () => smsFeature.sendSMS(simSubscriptionId, toPhoneNumber, sms),
      throwsA(isA<DevicePermissionException>()),
    );
  });

  group('registerToListenIncomingSMS', () {
    test('invokes unRegisterToListenSMS method on methodChannel', () {
      const unRegisterToListenSMS = 'unRegisterToListenSMS';
      smsFeature.unRegisterToListenIncomingSMS();
      verify(
        () => mockMethodChannel.invokeMethod<String>(unRegisterToListenSMS),
      ).called(1);
    });
    test('throws DevicePermissionException when permission is denied',
        () async {
      when(
        () => mockDevicePermissionManager
            .checkAndRequestPermission(DevicePermission.sms),
      ).thenAnswer((final _) async => DevicePermissionStatus.denied);

      await expectLater(
        smsFeature.registerToListenIncomingSMS(
          receivedMessage: (final OTPDetails otpDetails) {},
          receiveSMSTemplate:
              ReceiveSMSTemplate(smsTemplate: '', specialCharacter: ''),
        ),
        throwsA(isA<DevicePermissionException>()),
      );
    });

    test('registers to listen for incoming SMS when permission is granted',
        () async {
      when(
        () => mockDevicePermissionManager
            .checkAndRequestPermission(DevicePermission.sms),
      ).thenAnswer((final _) async => DevicePermissionStatus.granted);

      when(() => mockMethodChannel.invokeMethod<String>(any()))
          .thenAnswer((final _) async => '');

      await smsFeature.registerToListenIncomingSMS(
        receivedMessage: (final OTPDetails otpDetails) {},
        receiveSMSTemplate:
            ReceiveSMSTemplate(smsTemplate: '', specialCharacter: ''),
      );
      verify(() => mockMethodChannel.setMethodCallHandler(any())).called(1);
    });
  });

  group('_readOtpFromSMS', () {
    setUpAll(() {});

    test('returns OTP when smsTemplate and specialCharacter are provided', () {
      const otpMessage = 'Your OTP is 1234. ';
      final mockReceiveSMSTemplate = ReceiveSMSTemplate(
        smsTemplate: 'Your OTP is ####. ',
        specialCharacter: '#',
      );
      smsFeature.setReceivedSMSTemplate(mockReceiveSMSTemplate);
      final result = smsFeature.readOtpFromSMS(otpMessage);

      expect(result, '1234');
    });

    test('returns otp when part of otp message matches template', () {
      const otpMessage = 'Dont share Your OTP is 1234. dont share';
      final mockReceiveSMSTemplate = ReceiveSMSTemplate(
        smsTemplate: 'Your OTP is ####. ',
        specialCharacter: '#',
      );
      smsFeature.setReceivedSMSTemplate(mockReceiveSMSTemplate);
      final result = smsFeature.readOtpFromSMS(otpMessage);

      expect(result, '1234');
    });

    test('returns null when otp message varies from template', () {
      const otpMessage = 'Dont share Your OTP is 1234. dont share';
      final mockReceiveSMSTemplate = ReceiveSMSTemplate(
        smsTemplate: 'your OTP ####. ',
        specialCharacter: '#',
      );
      smsFeature.setReceivedSMSTemplate(mockReceiveSMSTemplate);
      final result = smsFeature.readOtpFromSMS(otpMessage);

      expect(result, isNull);
    });

    test('returns null when no OTP match', () {
      const otpMessage = 'Your OTP is dont share. ';
      final mockReceiveSMSTemplate = ReceiveSMSTemplate(
        smsTemplate: 'Your OTP is ####. ',
        specialCharacter: '#',
      );
      smsFeature.setReceivedSMSTemplate(mockReceiveSMSTemplate);
      final result = smsFeature.readOtpFromSMS(otpMessage);

      expect(result, isNull);
    });

    test('returns OTP when otpLength is provided', () {
      const otpMessage = 'Your OTP is 12345. ';
      final mockReceiveSMSTemplate = ReceiveSMSTemplate(
        otpLength: 5,
      );
      smsFeature.setReceivedSMSTemplate(mockReceiveSMSTemplate);
      final result = smsFeature.readOtpFromSMS(otpMessage);

      expect(result, '12345');
    });

    test('returns null when otpLength is provided but no OTP match', () {
      const otpMessage = 'Your OTP is 1234. ';
      final mockReceiveSMSTemplate = ReceiveSMSTemplate(
        otpLength: 5,
      );
      smsFeature.setReceivedSMSTemplate(mockReceiveSMSTemplate);

      final result = smsFeature.readOtpFromSMS(otpMessage);

      expect(result, isNull);
    });
  });

  group('isSimInformationChanged', () {
    test('returns false when SIM information has not changed', () async {
      when(
        () => mockDevicePermissionManager.checkAndRequestPermission(
          DevicePermission.phone,
        ),
      ).thenAnswer((final _) async => DevicePermissionStatus.granted);

      final cachedSimDetails = [
        SIMDetail(subscriptionID: '123', simSlotIndex: '0'),
      ];
      when(() => mockCache.getItem(key: 'simInfoKey'))
          .thenAnswer((final _) async => jsonEncode(cachedSimDetails));

      final eventStream = Stream<String>.fromIterable([
        jsonEncode([
          {'subscriptionID': '123', 'simSlotIndex': '0'},
        ]),
      ]);
      when(() => mockEventChannel.receiveBroadcastStream())
          .thenAnswer((final _) => eventStream);

      final result = await smsFeature.isSimInformationChanged();

      expect(result, isFalse);
    });

    test('returns true when SIM information has changed', () async {
      when(
        () => mockDevicePermissionManager.checkAndRequestPermission(
          DevicePermission.phone,
        ),
      ).thenAnswer((final _) async => DevicePermissionStatus.granted);

      final cachedSimDetails = [
        SIMDetail(subscriptionID: '123', simSlotIndex: '0'),
      ];
      when(() => mockCache.getItem(key: 'simInfoKey'))
          .thenAnswer((final _) async => jsonEncode(cachedSimDetails));

      final eventStream = Stream<String>.fromIterable([
        jsonEncode([
          {'subscriptionID': '456', 'simSlotIndex': '0'},
        ]),
      ]);
      when(() => mockEventChannel.receiveBroadcastStream())
          .thenAnswer((final _) => eventStream);

      final result = await smsFeature.isSimInformationChanged();

      expect(result, isTrue);
    });

    test('throws DevicePermissionException when permission is denied',
        () async {
      when(
        () => mockDevicePermissionManager.checkAndRequestPermission(
          DevicePermission.phone,
        ),
      ).thenAnswer((final _) async => DevicePermissionStatus.denied);

      expect(
        () => smsFeature.isSimInformationChanged(),
        throwsA(isA<DevicePermissionException>()),
      );
    });
  });

  group('onSMSReceived', () {
    test('set callback with the correct OTPDetails', () async {
      const messageBody = 'Your OTP is 1234';
      final mockReceiveSMSTemplate = ReceiveSMSTemplate(
        smsTemplate: 'Your OTP is ####',
        specialCharacter: '#',
      );
      final messageInJson = jsonEncode({'messageBody': messageBody});
      when(() => mockMethodCall.method).thenReturn('messageReceived');
      when(() => mockMethodCall.arguments).thenReturn(messageInJson);
      late OTPDetails o;

      smsFeature
        ..setRegisterForMessage((final p0) => o = p0)
        ..setReceivedSMSTemplate(mockReceiveSMSTemplate);

      await smsFeature.onSMSReceived(mockMethodCall);
      expect(o.otp, '1234');
    });
  });
}

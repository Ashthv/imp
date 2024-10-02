import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tcs_dff_shared_library/logger/logger.dart';
import 'package:tcs_dff_storage/cache/cache.dart';
import 'package:tcs_dff_storage/cache/cache_utils.dart';
import 'package:tcs_dff_types/exceptions.dart';

import '../permission/device_permission_manager.dart';
import '../permission/permission_types.dart';
import '../utils/string_constants.dart';
import 'otp_details.dart';
import 'receive_sms_template.dart';
import 'sim_detail.dart';

mixin SimSlotInfoProvider {
  Future<List<SIMDetail>> getSIMInformation();
}

class SMSFeature implements SimSlotInfoProvider {
  @visibleForTesting
  late MethodChannel methodChannel;
  @visibleForTesting
  late EventChannel eventChannel;

  late DevicePermissionManager devicePermissionManager;
  @visibleForTesting
  late Cache cache;

  final String simInfoCacheKey = 'simInfoKey';

  final cacheDuration = getExpiryDate(duration: const Duration(minutes: 10));

  /// A call back to send message details to app
  /// that is recieved from the BroadcastReceiver
  late Function(OTPDetails) _receivedMessage;

  late ReceiveSMSTemplate _receivedSMSTemplate;

  SMSFeature() {
    devicePermissionManager = DevicePermissionManager();
    cache = Cache();
    methodChannel = const MethodChannel('com.dff.device_feature');
    eventChannel = const EventChannel('com.dff.device_feature/sim_change');
  }

  Future<void> registerToListenIncomingSMS({
    required final Function receivedMessage,
    required final ReceiveSMSTemplate receiveSMSTemplate,
  }) async {
    final status = await devicePermissionManager.checkAndRequestPermission(
      DevicePermission.sms,
    );
    if (status.isGranted) {
      _receivedSMSTemplate = receiveSMSTemplate;
      _receivedMessage = receivedMessage as dynamic Function(OTPDetails);
      methodChannel.setMethodCallHandler(onSMSReceived);
      try {
        await methodChannel.invokeMethod<String>(
          registerToListenSMS,
        );
      } catch (e) {
        ConsoleLogger().error('Error:${e.toString()}');
      }
    } else {
      throw DevicePermissionException(
        error: Error(
          title: permissionDenyMessage,
          description: status.toString(),
        ),
      );
    }
  }

  void unRegisterToListenIncomingSMS() {
    try {
      methodChannel.invokeMethod<String>(
        unRegisterToListenSMS,
      );
    } catch (e) {
      ConsoleLogger().error('Error:${e.toString()}');
    }
  }

  ///Read message that is received from BroadcastReceiver
  Future<void> onSMSReceived(final MethodCall call) async {
    switch (call.method) {
      case messageReceived:
        final message = call.arguments as String;
        final messageInJson = jsonDecode(message) as Map<String, dynamic>;
        _receivedMessage(
          OTPDetails(
            otp: readOtpFromSMS(messageInJson['messageBody'] as String),
          ),
        );
    }
  }

  Future<List<SIMDetail>?> _getDataFromCache() async {
    List<SIMDetail>? simDetail;

    final data = await cache.getItem(
      key: simInfoCacheKey,
    );

    if (data != null) {
      final jsonOutput = (jsonDecode(data) as List<dynamic>)
          .map((final e) => e as Map<String, dynamic>)
          .map(SIMDetail.fromJson)
          .toList();

      simDetail = jsonOutput;
    }
    return simDetail;
  }

  @override
  Future<List<SIMDetail>> getSIMInformation() async {
    final cacheData = await _getDataFromCache();

    if (cacheData != null) {
      return cacheData;
    }

    final status = await devicePermissionManager.checkAndRequestPermission(
      DevicePermission.phone,
    );
    var simList = <SIMDetail>[];
    if (status.isGranted) {
      final result = await methodChannel.invokeMethod<String>(
        getSimInfo,
      );
      final jsonArray = json.decode(result!) as Iterable<dynamic>;
      if (jsonArray is List) {
        simList = List<SIMDetail>.from(
          jsonArray.map(
            (final e) => SIMDetail.fromJson(
              e as Map<String, dynamic>,
            ),
          ),
        );
      }

      await cache.setItem(
        key: simInfoCacheKey,
        data: jsonEncode(simList),
        expiryTime: cacheDuration,
      );

      return simList;
    } else {
      throw DevicePermissionException(
        error: Error(
          title: permissionDenyMessage,
          description: status.toString(),
        ),
      );
    }
  }

  Future<String?> sendSMS(
    final String simSubscriptionId,
    final String toPhoneNumber,
    final String sms,
  ) async {
    final status = await devicePermissionManager.checkAndRequestPermission(
      DevicePermission.sms,
    );
    if (status.isGranted) {
      final result = await methodChannel.invokeMethod<String>(
        sendSms,
        {
          phoneNumber: toPhoneNumber,
          message: sms,
          simSubscriptionID: simSubscriptionId,
        },
      );
      return result;
    } else {
      throw DevicePermissionException(
        error: Error(
          title: permissionDenyMessage,
          description: status.toString(),
        ),
      );
    }
  }

  Stream<List<SIMDetail>> onSIMChangeInformation() async* {
    final status = await devicePermissionManager.checkAndRequestPermission(
      DevicePermission.phone,
    );

    if (status.isGranted) {
      var isSubscriptionIdChanged = false;

      final cacheSimDetails = (await _getDataFromCache()) ?? [];

      await for (final value in eventChannel.receiveBroadcastStream()) {
        final jsonArray = json.decode(value as String) as List<dynamic>;
        final currentSimDetails = List<SIMDetail>.from(
          jsonArray.map(
            (final e) => SIMDetail.fromJson(
              e as Map<String, dynamic>,
            ),
          ),
        );

        if (cacheSimDetails.length == currentSimDetails.length) {
          for (var index = 0; index < cacheSimDetails.length; index++) {
            isSubscriptionIdChanged = cacheSimDetails[index].subscriptionID !=
                currentSimDetails[index].subscriptionID;
          }
        } else {
          isSubscriptionIdChanged = true;
        }

        if (isSubscriptionIdChanged) {
          await cache.setItem(
            key: simInfoCacheKey,
            data: jsonEncode(currentSimDetails),
            expiryTime: cacheDuration,
          );

          yield currentSimDetails;
        }
      }
    } else {
      throw DevicePermissionException(
        error: Error(
          title: permissionDenyMessage,
          description: status.toString(),
        ),
      );
    }
  }

  Future<bool> isSimInformationChanged() async {
    final status = await devicePermissionManager.checkAndRequestPermission(
      DevicePermission.phone,
    );

    if (status.isGranted) {
      var isSubscriptionIdChanged = false;

      final cacheSimDetails = (await _getDataFromCache()) ?? [];

      await for (final value in eventChannel.receiveBroadcastStream()) {
        final jsonArray = json.decode(value as String) as List<dynamic>;
        final currentSimDetails = List<SIMDetail>.from(
          jsonArray.map(
            (final e) => SIMDetail.fromJson(
              e as Map<String, dynamic>,
            ),
          ),
        );

        if (cacheSimDetails.length == currentSimDetails.length) {
          for (var index = 0; index < cacheSimDetails.length; index++) {
            isSubscriptionIdChanged = cacheSimDetails[index].subscriptionID !=
                currentSimDetails[index].subscriptionID;
          }
        } else {
          isSubscriptionIdChanged = true;
        }

        return isSubscriptionIdChanged;
      }

      return false;
    } else {
      throw DevicePermissionException(
        error: Error(
          title: permissionDenyMessage,
          description: status.toString(),
        ),
      );
    }
  }

  @visibleForTesting
  String? readOtpFromSMS(final String otpMessage) {
    if (_receivedSMSTemplate.smsTemplate != null) {
      final pattern = _receivedSMSTemplate.smsTemplate!.replaceAllMapped(
          RegExp('${_receivedSMSTemplate.specialCharacter!}+'), (final match) {
        final length = match.group(0)!.length;
        return '(\\d{$length})';
      });

      final regExp = RegExp(pattern);
      final match = regExp.firstMatch(otpMessage);
      if (match != null && match.groupCount > 0) {
        final otp = match.group(1);
        return otp;
      } else {
        return null;
      }
    } else if (_receivedSMSTemplate.otpLength != null) {
      final otpMatchPattern = RegExp(
        r'\b\d{' + _receivedSMSTemplate.otpLength.toString() + r'}\b',
        multiLine: true,
      );
      if (otpMatchPattern.allMatches(otpMessage).isNotEmpty) {
        return otpMatchPattern.allMatches(otpMessage).first.group(0);
      } else {
        return null;
      }
    }

    return null;
  }

  @visibleForTesting
  void setReceivedSMSTemplate(final ReceiveSMSTemplate receiveSMSTemplate) {
    _receivedSMSTemplate = receiveSMSTemplate;
  }

  @visibleForTesting
  void setRegisterForMessage(final Function(OTPDetails) receivedMessage) {
    _receivedMessage = receivedMessage;
  }
}

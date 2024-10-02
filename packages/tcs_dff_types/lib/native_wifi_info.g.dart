// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'native_wifi_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NativeWifiInfo _$NativeWifiInfoFromJson(Map<String, dynamic> json) =>
    NativeWifiInfo(
      ssid: json['ssid'] as String?,
      bssid: json['bssid'] as String?,
      macAddress: json['macAddress'] as String?,
      securityType: json['securityType'] as String?,
      frequency: json['frequency'] as int?,
      level: json['level'] as int?,
      netWorkId: json['netWorkId'] as int?,
    );

Map<String, dynamic> _$NativeWifiInfoToJson(NativeWifiInfo instance) =>
    <String, dynamic>{
      'ssid': instance.ssid,
      'bssid': instance.bssid,
      'macAddress': instance.macAddress,
      'securityType': instance.securityType,
      'frequency': instance.frequency,
      'level': instance.level,
      'netWorkId': instance.netWorkId,
    };

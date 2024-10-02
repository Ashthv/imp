// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proxy_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProxyInfo _$ProxyInfoFromJson(Map<String, dynamic> json) => ProxyInfo(
      isEnabled: json['isEnabled'] as bool,
      host: json['host'] as String?,
      port: json['port'] as int?,
    );

Map<String, dynamic> _$ProxyInfoToJson(ProxyInfo instance) => <String, dynamic>{
      'isEnabled': instance.isEnabled,
      'host': instance.host,
      'port': instance.port,
    };

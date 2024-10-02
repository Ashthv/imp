import 'package:json_annotation/json_annotation.dart';

part 'native_wifi_info.g.dart';

@JsonSerializable()
class NativeWifiInfo {
  final String? ssid;
  final String? bssid;
  final String? macAddress;
  final String? securityType;
  final int? frequency;
  final int? level;
  final int? netWorkId;

  NativeWifiInfo({
    this.ssid,
    this.bssid,
    this.macAddress,
    this.securityType,
    this.frequency,
    this.level,
    this.netWorkId,
  });

  factory NativeWifiInfo.fromJson(final Map<String, dynamic> json) =>
      _$NativeWifiInfoFromJson(json);

  Map<String, dynamic> toJson() => _$NativeWifiInfoToJson(this);
}

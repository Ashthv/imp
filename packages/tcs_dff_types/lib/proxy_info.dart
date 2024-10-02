import 'package:json_annotation/json_annotation.dart';

part 'proxy_info.g.dart';

@JsonSerializable()
class ProxyInfo {
  final bool isEnabled;
  final String? host;
  final int? port;

  ProxyInfo({
    required this.isEnabled,
    this.host,
    this.port,
  });

  factory ProxyInfo.fromJson(final Map<String, dynamic> json) =>
      _$ProxyInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ProxyInfoToJson(this);
}

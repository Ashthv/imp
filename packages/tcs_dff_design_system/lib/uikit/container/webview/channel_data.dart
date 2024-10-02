import 'dart:convert';

class WebViewChannelData {
  final String type;
  final String path;
  final Object? extra;

  WebViewChannelData({
    required this.type,
    required this.path,
    this.extra,
  });

  factory WebViewChannelData.fromJson(final String message) {
    final map = jsonDecode(message) as Map<String, dynamic>;
    return WebViewChannelData(
      type: map['type'] as String,
      path: map['path'] as String,
      extra: map['extra'] as Object?,
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'path': path,
        'extra': extra,
      };
}
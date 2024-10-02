class CacheItem {
  String? key;
  String? data;
  Duration? expiryTime;

  CacheItem({
    required this.key,
    required this.data,
    this.expiryTime,
  });

  Map<String, dynamic> toJson() {
    final dataMap = <String, dynamic>{};
    dataMap['key'] = key;
    dataMap['data'] = data;
    dataMap['expiryTime'] = expiryTime == null ? 0 : expiryTime!.inMilliseconds;
    return dataMap;
  }

  CacheItem.fromJson(final Map<String, dynamic> value) {
    key = value['key'] as String;
    data = value['data'] == null ? '' : value['data'] as String;
    expiryTime = Duration(milliseconds: value['expiryTime'] as int);
  }
}

import 'plugin_types.dart';

abstract interface class SharedPreferencePlugin implements Plugin {
  void setStringValue({
    required final String key,
    required final String value,
  });

  void setDoubleValue({
    required final String key,
    required final double value,
  });

  void setBoolValue({
    required final String key,
    required final bool value,
  });

  void setIntValue({
    required final String key,
    required final int value,
  });

  String? getStringValue({
    required final String key,
  });

  int? getIntValue({
    required final String key,
  });

  double? getDoubleValue({
    required final String key,
  });

  bool? getBoolValue({
    required final String key,
  });

  Future<void> setSecuredStringValue({
    required final String key,
    required final String value,
  });

  Future<void> setSecuredDoubleValue({
    required final String key,
    required final double value,
  });

  Future<void> setSecuredBoolValue({
    required final String key,
    required final bool value,
  });

  Future<void> setSecuredIntValue({
    required final String key,
    required final int value,
  });

  Future<String?> getSecuredStringValue({
    required final String key,
  });

  Future<int?> getSecuredIntValue({
    required final String key,
  });

  Future<double?> getSecuredDoubleValue({
    required final String key,
  });

  Future<bool?> getSecuredBoolValue({
    required final String key,
  });

  Future<bool> clearData();

  Future<void> deleteData({
    required final String key,
  });

  Future<void> clearSecuredData();

  Future<void> deleteSecuredData({
    required final String key,
  });
}

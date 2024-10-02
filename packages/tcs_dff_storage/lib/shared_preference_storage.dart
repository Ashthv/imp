import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcs_dff_types/plugin/shared_preference_plugin.dart';

class SharedPreferenceStorage implements SharedPreferencePlugin {
  late final FlutterSecureStorage _secureStorage;
  late final SharedPreferences _sharedPreferences;

  @override
  Future<void> init() async {
    _secureStorage = const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
    );
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Future<void> release() async {}

  @override
  double? getDoubleValue({required final String key}) =>
      _sharedPreferences.getDouble(key);

  @override
  int? getIntValue({required final String key}) =>
      _sharedPreferences.getInt(key);

  @override
  String? getStringValue({required final String key}) =>
      _sharedPreferences.getString(key);

  @override
  void setBoolValue({
    required final String key,
    required final bool value,
  }) =>
      _sharedPreferences.setBool(key, value);

  @override
  void setDoubleValue({
    required final String key,
    required final double value,
  }) =>
      _sharedPreferences.setDouble(key, value);

  @override
  void setIntValue({
    required final String key,
    required final int value,
  }) =>
      _sharedPreferences.setInt(key, value);

  @override
  void setStringValue({
    required final String key,
    required final String value,
  }) =>
      _sharedPreferences.setString(key, value);

  @override
  bool? getBoolValue({required final String key}) =>
      _sharedPreferences.getBool(key);

  @override
  Future<bool?> getSecuredBoolValue({required final String key}) async {
    final value = await _secureStorage.read(key: key);
    if (value != null) {
      return bool.parse(value);
    }
    return null;
  }

  @override
  Future<double?> getSecuredDoubleValue({required final String key}) async {
    final value = await _secureStorage.read(key: key);
    if (value != null) {
      return double.parse(value);
    }
    return null;
  }

  @override
  Future<int?> getSecuredIntValue({required final String key}) async {
    final value = await _secureStorage.read(key: key);
    if (value != null) {
      return int.parse(value);
    }
    return null;
  }

  @override
  Future<String?> getSecuredStringValue({required final String key}) async =>
      await _secureStorage.read(key: key);

  @override
  Future<void> setSecuredBoolValue({
    required final String key,
    required final bool value,
  }) async {
    await _secureStorage.write(key: key, value: value.toString());
  }

  @override
  Future<void> setSecuredDoubleValue({
    required final String key,
    required final double value,
  }) async {
    await _secureStorage.write(key: key, value: value.toString());
  }

  @override
  Future<void> setSecuredIntValue({
    required final String key,
    required final int value,
  }) async {
    await _secureStorage.write(key: key, value: value.toString());
  }

  @override
  Future<void> setSecuredStringValue({
    required final String key,
    required final String value,
  }) async {
    await _secureStorage.write(key: key, value: value.toString());
  }

  @override
  Future<bool> clearData() async => _sharedPreferences.clear();

  @override
  Future<void> deleteData({required final String key}) async =>
      _sharedPreferences.remove(key);

  @override
  Future<void> clearSecuredData() async => _secureStorage.deleteAll();

  @override
  Future<void> deleteSecuredData({required final String key}) async =>
      _secureStorage.delete(key: key);
}

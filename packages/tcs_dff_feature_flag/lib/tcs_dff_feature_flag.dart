library tcs_dff_feature_flag;

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:tcs_dff_types/plugin/feature_flag_plugin.dart';

export 'package:tcs_dff_feature_flag/tcs_dff_feature_flag.dart';

class FirebaseRemotePlugin implements FeatureFlagPlugin {
  late FirebaseRemoteConfig _firebaseRemoteConfig;
  late FirebaseOptions currentFirebaseOptions;
  late Duration fetchTimeOut;
  late Duration minimumFetchInterval;

  FirebaseRemotePlugin({
    required this.currentFirebaseOptions,
    required this.fetchTimeOut,
    required this.minimumFetchInterval,
  });

  Future<void> initialseRemoteConfig() async {
    _firebaseRemoteConfig = FirebaseRemoteConfig.instance;
    await _firebaseRemoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: fetchTimeOut,
        minimumFetchInterval: minimumFetchInterval,
      ),
    );
  }

  Future<void> initialseFirebase() async {
    await Firebase.initializeApp(
      options: currentFirebaseOptions,
    );
  }

  @override
  Future<void> init() async {
    await initialseFirebase();
    await initialseRemoteConfig();
    await _firebaseRemoteConfig.fetchAndActivate();
  }

  @override
  Future<void> release() async {}

  @override
  bool getBool(final String key) => _firebaseRemoteConfig.getBool(key);

  @override
  double getDouble(final String key) => _firebaseRemoteConfig.getDouble(key);

  @override
  int getInt(final String key) => _firebaseRemoteConfig.getInt(key);

  @override
  String getString(final String key) => _firebaseRemoteConfig.getString(key);
}

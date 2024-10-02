import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:tcs_dff_analytics/analytics/firebase_default_analytics.dart';

class DefaultFirebaseOptions {
  static PluginFirebaseOptions get firebaseOptions {
    if (kIsWeb) {
      return webFirebaseOptions;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return androidFirebaseOptions;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const PluginFirebaseOptions webFirebaseOptions = PluginFirebaseOptions(
    apiKey: '123',
    authDomain: 'productdemo',
    projectId: 'productdemo',
    storageBucket: 'productdemo',
    messagingSenderId: '123',
    appId: '123',
    measurementId: '123',
  );

  static const PluginFirebaseOptions androidFirebaseOptions =
      PluginFirebaseOptions(
    apiKey: '123',
    authDomain: 'productdemo',
    projectId: 'productdemo',
    storageBucket: 'productdemo',
    messagingSenderId: '123',
    appId: '123',
    measurementId: '123',
  );
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get firebaseOptions {
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

  static const FirebaseOptions webFirebaseOptions = FirebaseOptions(
    apiKey: 'test',
    authDomain: 'productdemo',
    projectId: 'productdemo',
    storageBucket: 'productdemo',
    messagingSenderId: '123',
    appId: '123',
    measurementId: 'G-123',
  );

  static const FirebaseOptions androidFirebaseOptions = FirebaseOptions(
    apiKey: 'test',
    appId: '123',
    messagingSenderId: '123',
    projectId: 'productdemo',
    storageBucket: 'productdemo',
  );
}
